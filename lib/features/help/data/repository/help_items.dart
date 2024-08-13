
import 'package:ecotyper/features/help/data/models/help_item.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class HelpItems{
  static List<HelpItem> list = [
    HelpItem(
      image: Assets.help.home,
      title: "Home",
      description: """
This is the starting point of the application. 
Here You can: 
  * Toggle the application sound (top-left). 
  * View profile (top-right). 
  * Play a game.
  * View Leaderboard
      """,
    ),
    HelpItem(
      image: Assets.help.theme,
      title: "Select Theme",
      description: """
In this screen you get to select the sustainable theme you are interested in and the level of difficulty (easy, medium and hard).
The difficulty determines how fast the cloud of words falls.
      """,
    ),
    HelpItem(
      image: Assets.help.level,
      title: "Level",
      description: """
In this screen, you can select the game level. Each level determines the length of the words in the facts revealed at the end of the game.
    """,
    ),
    HelpItem(
      image: Assets.help.prologue,
      title: "Prologue",
      description: """
This screen serves as an introduction to the gameplay. It previews the facts that will be revealed at the end of the game.
""",
    ),
    HelpItem(
      image: Assets.help.playing,
      title: "Game play",
      description: """
You get to see falling clouds of words. Type out the correct word to make the cloud vanish and earn XP points. 
You have the option to pause the gameplay and access a menu that allows you to: 
* Toggle sound effects 
* View the help menu 
* End the game 
* Resume.
""",
    ),
    HelpItem(
      image: Assets.help.gameOver,
      title: "Game over",
      description: """
When the game is over you get to see your score and also have the option to share your fact card (requires you to be signed in).
In addition you can navigate to other screens on the app.
""",
    ),
  ];
}