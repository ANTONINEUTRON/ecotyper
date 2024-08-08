import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_state.dart';
import 'package:ecotyper/features/home/ui/pages/home_page.dart';
import 'package:ecotyper/shared/constants.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (WidgetsBinding.instance.lifecycleState != null) {
      onApplifecycleUpdate(WidgetsBinding.instance.lifecycleState!);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onApplifecycleUpdate(state);
  }

  void onApplifecycleUpdate(AppLifecycleState state) {
    var bloc = context.read<AppBloc>();
    switch (state) {
      case AppLifecycleState.resumed:
        print("To play sound if user option is true");
        if (bloc.state.playMusicStatus != PlayMusicStatus.stopped) {
          bloc.playMusic();
        }
        break;
      case AppLifecycleState.inactive:
        print("To pause sound if user option is true");
        if (bloc.state.playMusicStatus == PlayMusicStatus.play) {
          bloc.pauseMusic();
        }
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
