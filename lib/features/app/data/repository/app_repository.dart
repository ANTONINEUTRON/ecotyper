import 'package:hive_flutter/hive_flutter.dart';
import 'package:ecotyper/shared/constants.dart';

class AppRepository {
  var toPlayBox = Hive.box<bool>(AppConstants.toPlayMusic);
  var toPlayKey = "To Play Music Key";

  Future setToPlayMusic(bool toPlay) async {
    await toPlayBox.put(toPlayKey, toPlay);
  }

  Future<bool> getToPlayMusic() async {
    return toPlayBox.get(toPlayKey) ?? true;
  }
}
