import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'sections.g.dart';

@HiveType(typeId: 3)
enum Section {
  @HiveField(0)
  climateChange("Climate Change"),
  @HiveField(1)
  sustainableCommunities("Sustainable Communities"),
  @HiveField(2)
  lifeOnLand("Life on Land"),
  @HiveField(3)
  cleanEnergy("Clean Energy"),
  @HiveField(4)
  oceanLife("Clean Water and Sanitation"),
  @HiveField(5)
  cleanWaterAndSanitation("Ocean Life");

  const Section(this.title);

  final String title;

  static IconData getAssociatedIcon(Section section) {
    switch (section) {
      //
      case Section.climateChange:
        return Icons.cloud;
      case Section.sustainableCommunities:
        return Icons.people;
      case Section.lifeOnLand:
        return Icons.forest;
      case Section.cleanEnergy:
        return Icons.solar_power_outlined;
      case Section.oceanLife:
        return Icons.water;
      case Section.cleanWaterAndSanitation:
        return Icons.water;
    }
  }
}
