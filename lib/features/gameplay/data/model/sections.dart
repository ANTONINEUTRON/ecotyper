import 'package:hive/hive.dart';

part 'sections.g.dart';

@HiveType(typeId: 3)
enum Sections {
  @HiveField(0)
  scienceAndTech("Science and Technology"),
  @HiveField(1)
  historyAndCulture("History and Culture"),
  @HiveField(2)
  natureAndEnvironment("Nature and Environment"),
  @HiveField(3)
  healthAndWellness("Health and Wellness"),
  @HiveField(4)
  artsAndEntertainment("Arts and Entertainment"),
  @HiveField(5)
  travelAndExploration("Travel and Exploration");

  const Sections(this.title);

  final String title;
}
