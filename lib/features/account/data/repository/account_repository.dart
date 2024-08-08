import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ecotyper/features/account/data/model/user.dart' as user_model;
import 'package:ecotyper/features/account/data/model/user_meta.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/shared/constants.dart';
import 'package:ecotyper/shared/exception/tn_exception.dart';
import 'package:ecotyper/shared/utils/handle_auth_handler_exception_message.dart';

class AccountRepository {
  var fbAuth = FirebaseAuth.instance;
  var userColl =
      FirebaseFirestore.instance.collection(AppConstants.userCollection);
  var storage = FirebaseStorage.instance;

  final _scoresBox = Hive.box<Score>(AppConstants.scoresBox);
  final _userMetaBox = Hive.box<UserMeta>(AppConstants.userMetaBox);

  bool isUserSignedIn() {
    return fbAuth.currentUser != null;
  }

  /// Sign in the user and return user instance
  Future<user_model.User> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential;
    try {
      // signin user to firebase auth
      userCredential = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // access firestore and fetch user details
      return await _fetchUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthHandlerException(handleAuthExceptionMessage(e));
    }
  }

  Future<user_model.User> _fetchUserData(String id) async {
    var userDocSnapshot = await userColl
        .doc(id)
        .withConverter<user_model.User>(
          fromFirestore: (snapshot, _) =>
              user_model.User.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, _) => value.toJson(),
        )
        .get();
    print("HELLLLOSSS");
    print(userDocSnapshot.data());

    return userDocSnapshot.data()!;
  }

  /// Create user account on firebase auth
  Future<user_model.User> createUserWithEmailAndPassword({
    required user_model.User user,
    required String password,
    File? profilePics,
  }) async {
    // create user on firebase auth
    UserCredential userCredential;
    try {
      userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthHandlerException(handleAuthExceptionMessage(e));
    }
    //Send verification email
    userCredential.user?.sendEmailVerification();

    // save user details to firestore
    // The userId to be updated into the model
    var user2 = userCredential.user;
    var userId = user2!.uid;
    var dp = user2.photoURL;

    await userColl.doc(userId).set(user
        .copyWith(
          id: userId,
          displayPics: dp ?? "",
        )
        .toJson());

    return user.copyWith(id: userId);
  }

  // Future<void> signInWithGoogle({
  //   required String email,
  //   required String password,
  // }) async {}

  Future<void> logoutUser() async {
    await fbAuth.signOut();
  }

  Future<user_model.User?> getSignedUser() async {
    var currentUser = fbAuth.currentUser;
    if (currentUser == null) return null;
    var user = await _fetchUserData(currentUser.uid);

    if (user.isVerified != fbAuth.currentUser!.emailVerified) {
      user = user.copyWith(isVerified: fbAuth.currentUser!.emailVerified);
      updateUserProfile(user);
    }

    return user;
  }

  Future<void> updateUserProfile(user_model.User user) async {
    // store user profile to remote provider
    userColl.doc(user.id).update(user.toJson());
  }

  // Future<void> verifyUserEmail(String email) async {
  //   fbAuth.currentUser!.verifyBeforeUpdateEmail(email);
  // }

  // Future<bool> isUserVerified() async {
  //   return fbAuth.currentUser!.emailVerified;
  // }

  Future<String> uploadPP({
    required File file,
    required String userId,
  }) async {
    final reference = storage.ref().child('profile_pics/$userId');

    // Create a reference to the file you want to upload
    final uploadTask = reference.putFile(file);

    // Wait for the upload to finish
    final snapshot = await uploadTask.whenComplete(() => null);

    // Get the download URL for the uploaded file
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }

  Future<void> updateUserPassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    //Check if oldpassword passed is valid
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: fbAuth.currentUser!.email!,
        password: oldPassword,
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      throw OldPasswordNotMatchException();
    }
    //
    await fbAuth.currentUser!.updatePassword(newPassword);
  }

  int getUserScores() {
    int total = 0;
    for (Score score in _scoresBox.values) {
      total += score.score;
    }
    return total;
  }

  int getUserBestScore() {
    int highest = 0;
    for (Score score in _scoresBox.values) {
      if (score.score > highest) highest = score.score;
    }
    return highest;
  }

  void storeUserMetaLocally({required UserMeta userMeta}) async {
    await _userMetaBox.put(AppConstants.userMetaKey, userMeta);
  }

  void clearUserMeta() async {
    await _userMetaBox.clear();
  }

  // return stored instance
  // If user meta is empty
  // initialize and return a new instance
  UserMeta getLocalUserMeta() {
    return _userMetaBox.isEmpty
        ? UserMeta()
        : _userMetaBox.get(AppConstants.userMetaKey)!;
  }

  // Stream<bool> hasBeenVerifiedStream() {
  //   //Keep checking if user has clicked on the link
  //   return Stream.periodic(
  //     const Duration(milliseconds: 700),
  //     (computationCount) => fbAuth.currentUser?.emailVerified ?? false,
  //   );
  // }
}
