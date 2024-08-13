import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/data/model/user_meta.dart';
import 'package:ecotyper/features/account/data/repository/account_repository.dart';
import 'package:ecotyper/features/app/data/repository/app_repository.dart';
import 'package:ecotyper/features/app/widget/app.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ecotyper/features/gameplay/bloc/timer_bloc.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:ecotyper/firebase_options.dart';
import 'package:ecotyper/shared/constants.dart';
import 'package:ecotyper/shared/utils/check_for_internet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //
  // Initialize HIVE
  // 6 is currently the highest TypeId
  await Hive.initFlutter();
  Hive.registerAdapter(FactImplAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(LevelsAdapter());
  Hive.registerAdapter(ScoreImplAdapter());
  Hive.registerAdapter(DifficultyAdapter());
  Hive.registerAdapter(UserMetaImplAdapter());

  await Hive.openBox<Fact>(AppConstants.playedFacts);
  await Hive.openBox<Score>(AppConstants.scoresBox);
  await Hive.openBox<UserMeta>(AppConstants.userMetaBox);
  await Hive.openBox<bool>(AppConstants.toPlayMusic);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    checkForInternetConnection();
    //
    //
    // Initialize screenutil for responsiveness
    ScreenUtil.init(
      context,
      designSize: const Size(430, 932),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AppRepository()),
        RepositoryProvider(create: (context) => GameRepository()),
        RepositoryProvider(create: (context) => AccountRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
              gameRepository: context.read<GameRepository>(),
              appRepository: context.read<AppRepository>(),
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => LeaderboardBloc(
              gameRepository: context.read<GameRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => GameplayBloc(
              gameRepository: context.read<GameRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TimerBloc(),
          ),
          BlocProvider(
            create: (context) => AccountBloc(
              accountRepository: context.read<AccountRepository>(),
              gameRepository: context.read<GameRepository>(),
            ),
            lazy: false,
          ),
        ],
        child: const App(),
      ),
    );
  }
}
