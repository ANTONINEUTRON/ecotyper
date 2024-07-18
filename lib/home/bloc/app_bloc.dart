import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:ecotyper/features/home/bloc/app_state.dart';
import 'package:ecotyper/shared/utils/check_for_internet.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc({required this.gameRepository}) : super(const AppState()) {
    // loadPassageIfFirstInstall();
    initializeInternetCheck();
  }

  final GameRepository gameRepository;

  void initializeInternetCheck() async {
    Stream.periodic(
      const Duration(seconds: 5),
      (computationCount) async {
        return await checkForInternetConnection();
      },
    ).listen((event) async {
      emit(
        state.copyWith(
          isConnectedToInternet: await event,
        ),
      );
    });
  }

  void notifyUser(String message) async {
    emit(
      state.copyWith(notifyMessage: message),
    );
  }

  void clearNotificationMsg() async {
    emit(
      state.copyWith(notifyMessage: null),
    );
  }
  // void loadPassageIfFirstInstall() async {
  //   var unplayedPassagesCount = await gameRepository.unplayedPassagesCount();
  //   var playedPassagesCount = await gameRepository.playedPassagesCount();
  //   var userHasNotInitializeGame =
  //       unplayedPassagesCount == 0 && playedPassagesCount == 0;

  //   // check for network connection before progressing
  //   if (!(await checkForInternetConnection())) {
  //     if (userHasNotInitializeGame) {
  //       emit(
  //         state.copyWith(
  //             loadingPassageState: LoadingPassageState.noNetworkForInitialization),
  //       );
  //     }

  //     return;
  //   }

  //   try {
  //     // Check if it is the first time the user is opening the app
  //     if (userHasNotInitializeGame) {
  //       // let user know that game is being initialized
  //       emit(
  //         state.copyWith(loadingPassageState: LoadingPassageState.initializing),
  //       );

  //       await gameRepository.fetchPassagesIntoLocalStorage();

  //       emit(
  //         state.copyWith(loadingPassageState: LoadingPassageState.goodToGo),
  //       );
  //     }
  //   } on NoRemotePassageFoundException catch (e) {
  //     debugPrint(e.message);
  //     emit(
  //       state.copyWith(loadingPassageState: LoadingPassageState.noPassageFound),
  //     );
  //   } catch (e, s) {
  //     emit(
  //       state.copyWith(loadingPassageState: LoadingPassageState.unknownError),
  //     );
  //     if (kDebugMode) {
  //       print(e);
  //       print(s);
  //     }
  //   }
  // }
}
