import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/features/home/ui/pages/home_page.dart';
import 'package:ecotyper/shared/constants.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          secondary: const Color(0XFFE6A479),
          tertiary: const Color(0XFF723412),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.meriendaTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
