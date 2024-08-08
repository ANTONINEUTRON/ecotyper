import 'package:hive/hive.dart';

part 'difficulty.g.dart';

@HiveType(typeId: 5)
enum Difficulty {
  @HiveField(0)
  easy(
    name: "Easy",
    speed: 1,
  ),
  @HiveField(1)
  medium(
    name: "Medium",
    speed: 0.8,
  ),
  @HiveField(2)
  hard(
    name: "Hard",
    speed: 0.7,
  );

  const Difficulty({
    required this.name,
    required this.speed,
  });
  final String name;
  final double speed; //per character
}