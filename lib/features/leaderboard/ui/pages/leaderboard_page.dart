import 'package:flutter/material.dart';
import 'package:ecotyper/features/home/ui/pages/home_page.dart';
import 'package:ecotyper/features/leaderboard/ui/widgets/global_leaderboard.dart';
import 'package:ecotyper/features/leaderboard/ui/widgets/personal_score.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const LeaderboardPage(),
      );

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushReplacement(
          HomePage.route(),
        );
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            PersonalScore(),
            GlobalLeaderboard(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => setState(() {
            _index = value;
          }),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.token_rounded),
              label: "Personal",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "Global",
            ),
          ],
        ),
      ),
    );
  }
}
