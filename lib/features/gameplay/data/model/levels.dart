import 'package:hive/hive.dart';

part 'levels.g.dart';

@HiveType(typeId: 2)
enum Levels {
  @HiveField(0)
  level_1(
    title: "Level 1",
    rangeOfValue: "45 - 55",
    wordPlayLength: 6,
    easyTimeToCompleteFall: 40,
    endPosition: 1.1,
  ),
  @HiveField(1)
  level_2(
    title: "Level 2",
    rangeOfValue: "60 - 80",
    wordPlayLength: 12,
    easyTimeToCompleteFall: 55,
    endPosition: 0.60,
  ),
  @HiveField(2)
  level_3(
    title: "Level 3",
    rangeOfValue: "90 - 130",
    wordPlayLength: 18,
    easyTimeToCompleteFall: 70,
    endPosition: 0.50,
  ),
  @HiveField(3)
  level_4(
    title: "Level 4",
    rangeOfValue: "145 - 160",
    wordPlayLength: 24,
    easyTimeToCompleteFall: 85,
    endPosition: 0.25,
  ),
  @HiveField(4)
  level_5(
    title: "Level 5",
    rangeOfValue: "175 - 210",
    wordPlayLength: 32,
    easyTimeToCompleteFall: 90,
    endPosition: 0.25,
  );

  const Levels({
    required this.title,
    required this.rangeOfValue,
    required this.wordPlayLength,
    required this.easyTimeToCompleteFall,
    required this.endPosition,
  });
  final String title;
  final String rangeOfValue;
  final int wordPlayLength;
  final int easyTimeToCompleteFall;
  final double endPosition;

  static Levels getNextLevel(Levels levelPlayed) {
    switch (levelPlayed) {
      case Levels.level_1:
        return Levels.level_2;

      case Levels.level_2:
        return Levels.level_3;

      case Levels.level_3:
        return Levels.level_4;

      case Levels.level_4:
        return Levels.level_5;

      case Levels.level_5:
        return Levels.level_5;
    }
  }
}
