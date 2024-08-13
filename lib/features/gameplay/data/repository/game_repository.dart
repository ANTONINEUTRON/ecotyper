import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:ecotyper/features/account/data/model/user.dart';
import 'package:ecotyper/features/leaderboard/data/models/leaderboard_player.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/features/gameplay/data/providers/gemini_provider.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';
import 'package:ecotyper/shared/constants.dart';

class GameRepository {
  final _geminiProvider = GeminiProvider();

  final _playedFactsBox = Hive.box<Fact>(AppConstants.playedFacts);
  final _scoresBox = Hive.box<Score>(AppConstants.scoresBox);

  final scoreDB = FirebaseFirestore.instance.collection("scores");
  final userDB = FirebaseFirestore.instance.collection("users");
  final factDB = FirebaseFirestore.instance.collection("facts");

  /// Fetch facts from AI
  /// return to UI
  Future<Fact> generateFact({
    required Section section,
    required Levels levels,
  }) async {
    return await _geminiProvider.getFact(
      section: section,
      levels: levels,
    );
  }

  void saveFactToDB({required Fact fact}) {
    factDB.doc(fact.id).set(fact.toJson());
  }

  Future<void> saveFactsToLocalStorage({required Fact fact}) async {
    await _playedFactsBox.put(fact.id, fact);
  }

  /// This function returns score & fact pair
  /// If section is provided it returns all the facts that matched the section
  /// else return all facts
  Future<Map<Score, Fact>> fetchPlayedFacts({Section? section}) async {
    List<Score> scores = _scoresBox.values.toList();
    Map<Score, Fact> mapToBeReturned = {};

    for (var score in scores) {
      Fact? fact = _playedFactsBox.get(score.factId);
      if (fact != null) {
        if (section == null) {
          mapToBeReturned[score] = fact;
        } else if (fact.section == section) {
          mapToBeReturned[score] = fact;
        }
      }
    }

    return mapToBeReturned;
  }

  /// This function will save score locally if user doesn't have an account
  /// If user is registered a copy of their account will be stored remotely
  /// This is tracked by checking if the user ID is empty
  Future<void> saveScore(Score score) async {
    // store locally
    await _scoresBox.put(score.factId, score);

    if (score.userId.isNotEmpty) {
      // Save to remote db
      scoreDB.doc(score.id).set(score.toJson());
    }
  }

  Future<void> clearLocalScoreAndFacts() async {
    _playedFactsBox.clear();
    _scoresBox.clear();
  }

  void fetchAndSaveRemoteScoresAndFacts({required User user}) async {
    // fetch scores of user
    var scores = await scoreDB
        .where("userId", isEqualTo: user.id)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Score.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (scores.docs.isNotEmpty) {
      // extract factsId from scores and fetch associated facts
      List<String> listOfFactsId = scores.docs.map(
        (queryDocumentSnapshot) {
          return queryDocumentSnapshot.data().factId;
        },
      ).toList();
      var facts = await factDB
          .where("id", whereIn: listOfFactsId)
          .withConverter(
            fromFirestore: (snapshot, options) =>
                Fact.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, options) => value.toJson(),
          )
          .get();

      for (var i = 0; i < scores.docs.length; i++) {
        // save facts to Box
        var fact = facts.docs[i].data();
        _playedFactsBox.put(fact.id, fact);

        // save scores to Box
        var score = scores.docs[i].data();
        _scoresBox.put(score.factId, score);
      }
    }
  }

  // This to be rewritten when cloud functions has been setup
  Future<List<LeaderboardPlayer>> getGlobalPlayers() async {
    // Fetch all scores
    var querySnapshot = await scoreDB
        .withConverter<Score>(
          fromFirestore: (snapshot, options) => Score.fromJson(
            snapshot.data() ?? {},
          ),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    List<Score> listOfScores = querySnapshot.docs
        .map(
          (docSnap) => docSnap.data(),
        )
        .toList();

    // Group scores by user ID
    Map<String, int> mapOfUserIdToScore = {};
    for (Score score in listOfScores) {
      mapOfUserIdToScore[score.userId] =
          (mapOfUserIdToScore[score.userId] ?? 0) + score.score;
    }

    // Get all users based on their ID
    // Map of userId to User
    Map<String, User> mapOfUserIdToUser =
        await getUsersFromIds(ids: mapOfUserIdToScore.keys.toList());
    // print(users);
    // print(listOfScores);
    //Try to create a list of top users to be forwared to UI

// // Sort user IDs by total score (descending)
// List<String> topUsers = userScores.keys.toList()..sort((a, b) => userScores[b]! - userScores[a]!);

    //Sort scores around user ID

    // add to map of user id to score sum

    // get all user ids from db and create object to return

    // returm list of model

    return mapOfUserIdToScore.keys.map(
      (userId) {
        return LeaderboardPlayer(
            user: mapOfUserIdToUser[userId]!,
            overall: mapOfUserIdToScore[userId] ?? 0);
      },
    ).toList();
  }

  Future<Map<String, User>> getUsersFromIds({required List<String> ids}) async {
    if (ids.isEmpty) return {};

    QuerySnapshot<User> querySnapshot = await userDB
        .where("id", whereIn: ids)
        .withConverter<User>(
          fromFirestore: (snapshot, options) =>
              User.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    // return a map of userId to User, It will facilitate faster access
    Map<String, User> map = {};
    for (var user in querySnapshot.docs) {
      map[user.data().id] = user.data();
    }
    return map;
  }

  /// This function saves locally scores and facts without user linked to it to remote db
  Future<void> saveLocalScoresAndFactsToRemote({required User user}) async {
    List<Score> localScores = _scoresBox.values.toList();

    var scoresWithNoAttachedUser =
        localScores.where((score) => score.userId.isNotEmpty);

    List<Fact?> factsToSave = scoresWithNoAttachedUser.map((score) {
      return _playedFactsBox.get(score.factId);
    }).toList();

    //Saving scoresWithNoAttachedUser and factsToSave to remote DB
    for (var score in scoresWithNoAttachedUser) {
      scoreDB.doc(score.id).set(
            score.copyWith(userId: user.id).toJson(),
          );
    }

    for (var fact in factsToSave) {
      if (fact != null) {
        factDB.doc(fact.id).set(fact.toJson());
      }
    }
  }
}
