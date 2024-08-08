// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:ecotyper/features/gameplay/data/model/score.dart';
// // import 'package:ecotyper/features/gameplay/data/model/passage.dart';

// class SupabaseProvider {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   late SupabaseQueryBuilder _scoreQueryBuilder;
//   // late SupabaseQueryBuilder _passageQueryBuilder;


//   SupabaseProvider() {
//     _scoreQueryBuilder = _supabase.from("scores");
//   }

//   Future<void> saveScore({required Score score})async{
// _scoreQueryBuilder.select().g
//   }

//   // Future<List<Passage>> getPassages({
//   //   int limit = 500,
//   //   int startIndex = 0,
//   //   required List<int> alreadyDownloaded,
//   // }) async {
//   //   var response = await _passageQueryBuilder
//   //       .select('*')
//   //       .not("id", "in", alreadyDownloaded)
//   //       .limit(limit)
//   //       .withConverter(
//   //         (data) => data.map((section) => Passage.fromJson(section)).toList(),
//   //       );
//   //   return response;
//   // }

//   // Future<void> getDifficulty() async {}
// }
