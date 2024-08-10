import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/data/model/user.dart';
import 'package:ecotyper/features/account/data/model/user_meta.dart';
import 'package:ecotyper/features/account/data/repository/account_repository.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:ecotyper/shared/exception/tn_exception.dart';
import 'package:ecotyper/shared/utils/check_for_internet.dart';

class AccountBloc extends Cubit<AccountState> {
  AccountBloc({
    required this.accountRepository,
    required this.gameRepository,
  }) : super(const AccountState()) {
    _initBloc();
  }

  final AccountRepository accountRepository;
  final GameRepository gameRepository;

  void _initBloc() async {
    if (accountRepository.isUserSignedIn() &&
        (await checkForInternetConnection())) {
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signedIn,
          user: await accountRepository.getSignedUser(),
        ),
      );
    }
  }

  void signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // emit processing state
    emit(
      state.copyWith(accountStatus: AccountStatus.processing),
    );

    // Sign user in
    try {
      User user = await accountRepository.signInUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signedIn,
          user: user,
        ),
      );

      //
      //Save user local score to remote
      await gameRepository.saveLocalScoresAndFactsToRemote(user: user);

      //
      //Fetch and store locally user facts and scores if exist on remote server
      gameRepository.fetchAndSaveRemoteScoresAndFacts(user: user);


      //store usermeta to local box
      accountRepository.storeUserMetaLocally(userMeta: user.userMeta!);
    } on AuthHandlerException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          accountStatus: AccountStatus.authHandlerException,
          authHandlerException: e,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signInError,
        ),
      );
    }
  }

  void createUserAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    // emit processing state
    emit(
      state.copyWith(accountStatus: AccountStatus.processing),
    );

    // Create user model
    // Set user Id as empty
    User user = User(
      id: "",
      email: email,
      name: name,
      userMeta: getUserMeta(),
    );
    try {
      user = await accountRepository.createUserWithEmailAndPassword(
        user: user,
        password: password,
      );
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signedIn,
          user: user,
        ),
      );


      //
      //Save user local score to remote
      await gameRepository.saveLocalScoresAndFactsToRemote(user: user);
    } on AuthHandlerException catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          accountStatus: AccountStatus.authHandlerException,
          authHandlerException: e,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signInError,
        ),
      );
    }
  }

  /// On log out
  /// clear the locally stored facts and score
  /// then emit logout status
  void logout() async {
    try {
      await gameRepository.clearLocalScoreAndFacts();

      await accountRepository.logoutUser();

      emit(
        AccountState(),
        // state.copyWith(
        //   accountStatus: AccountStatus.signedOut,
        //   // user: null,
        // ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          accountStatus: AccountStatus.signInError,
        ),
      );
    }
  }

  void updateUserDeatils({
    required String name,
    required String email,
  }) async {
    if (name == state.user!.name) {
      emit(
        state.copyWith(
          updateAccountStatus: UpdateAccountStatus.updated,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        updateAccountStatus: UpdateAccountStatus.processing,
      ),
    );

    try {
      var updatedUser = state.user!.copyWith(
        name: name,
        email: email,
      );
      await accountRepository.updateUserProfile(
        updatedUser,
      );
      emit(
        state.copyWith(
          user: updatedUser,
          updateAccountStatus: UpdateAccountStatus.updated,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          updateAccountStatus: UpdateAccountStatus.error,
        ),
      );
    }
  }

  void unlockNextLevel({required Levels levelPlayed}) async {
    var userMeta = getUserMeta();

    var accessibleLevels = userMeta.accessibleLevels;
    var nextLevel = Levels.getNextLevel(levelPlayed);

    // The check ensure only levels that have not been played unlocks
    //  &&
    //     accessibleLevels.length < Levels.values.length
    if (!accessibleLevels.contains(nextLevel)) {
      // update userMeta and update local store
      var updatedUserMeta = userMeta.copyWith(
        accessibleLevels: [
          ...accessibleLevels,
          nextLevel,
        ],
      );
      accountRepository.storeUserMetaLocally(userMeta: updatedUserMeta);

      // If user is logged in update remote userMeta
      if (state.user != null) {
        var user = state.user!;
        var updatedUser = user.copyWith(
          userMeta: updatedUserMeta,
        );
        emit(
          state.copyWith(
            user: updatedUser,
          ),
        );

        accountRepository.updateUserProfile(
          updatedUser,
        );
      }
    }
  }

  void setUserSelectedDifficulty(Difficulty difficulty) {
    var userMeta = getUserMeta();

    if (userMeta.selectedDifficulty != difficulty) {
      // update meta and store locally
      var updatedUserMeta = userMeta.copyWith(
        selectedDifficulty: difficulty,
      );
      accountRepository.storeUserMetaLocally(userMeta: updatedUserMeta);

      // update user metadata if they are logged in
      if (state.user != null) {
        var user = state.user!;
        var updatedUser = user.copyWith(
          userMeta: updatedUserMeta,
        );

        emit(
          state.copyWith(
            user: updatedUser,
          ),
        );

        accountRepository.updateUserProfile(
          updatedUser,
        );
      }
    }
  }

  // void _updateUserMeta(User updatedUser) {
  //   emit(
  //     state.copyWith(
  //       user: updatedUser,
  //     ),
  //   );

  //   accountRepository.updateUserProfile(
  //     updatedUser,
  //   );

  //   accountRepository.storeUserMetaLocally(userMeta: updatedUser.userMeta!);
  // }

  UserMeta getUserMeta() {
    if (state.user != null) {
      return state.user!.userMeta!;
    }
    return accountRepository.getLocalUserMeta();
  }

  void updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(updatePasswordStatus: UpdatePasswordStatus.processing),
    );
    try {
      await accountRepository.updateUserPassword(
          oldPassword: oldPassword, newPassword: newPassword);
      emit(
        state.copyWith(updatePasswordStatus: UpdatePasswordStatus.updated),
      );
    } on OldPasswordNotMatchException catch (e, s) {
      debugPrint("${e.message}\n$s");

      emit(
        state.copyWith(
          updatePasswordStatus: UpdatePasswordStatus.oldPasswordNotMatch,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          updatePasswordStatus: UpdatePasswordStatus.error,
        ),
      );
    }
  }

  void uploadProfilePics() async {
    try {
      //open selector allowing only selected video format
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null) {
        File file = File(result.paths.first!);
        //Save to online storage
        var url = await accountRepository.uploadPP(
          file: file,
          userId: state.user!.id,
        );

        emit(
          state.copyWith(
            user: state.user!.copyWith(displayPics: url),
            uploadPPStatus: UploadPPStatus.uploaded,
          ),
        );

        accountRepository.updateUserProfile(state.user!);
      } else {
        throw FileNotSelectedException();
      }
    } on FileNotSelectedException catch (e) {
      emit(
        state.copyWith(
          uploadPPStatus: UploadPPStatus.fileNotSelected,
        ),
      );

      debugPrint(e.message);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          uploadPPStatus: UploadPPStatus.error,
        ),
      );
    }
  }

  void resetUpdateAccountStatus() async => emit(
        state.copyWith(
          updateAccountStatus: UpdateAccountStatus.initial,
        ),
      );

  void resetUpdateProfilePicsStatus() async => emit(
        state.copyWith(
          uploadPPStatus: UploadPPStatus.initial,
        ),
      );

  void resetUpdatePasswordStatus() async => emit(
        state.copyWith(
          updatePasswordStatus: UpdatePasswordStatus.initial,
        ),
      );

  void resetAccountStatus() async {
    emit(
      state.copyWith(
        accountStatus: AccountStatus.signedOut,
      ),
    );
  }

  String getUserTotalScore() {
    int totalScore = accountRepository.getUserScores();

    return _formatNumber(totalScore);
  }

  String getUserBestScore() {
    return accountRepository.getUserBestScore().toString();
  }

  String _formatNumber(int number) {
    if (number < 1000) {
      return number.toString(); // No formatting for numbers less than 1000
    } else if (number < 1000000) {
      return "${(number / 1000).toStringAsFixed(1)}k"; // Format as thousands (k)
    } else if (number < 1000000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M"; // Format as millions (M)
    } else if (number < 1000000000000) {
      return "${(number / 1000000000).toStringAsFixed(1)}B"; // Format as billions (B)
    } else {
      return "${(number / 1000000000000).toStringAsFixed(1)}T"; // Format as billions (B)
    }
  }

  void sendUserPasswordResetMail(String emailAddress) async {
    emit(
      state.copyWith(
        resetPasswordStatus: ResetPasswordStatus.sent,
      ),
    );
    print("Got there");
    try {
      await accountRepository.sendUserResetMail(emailAddress);
      print("Done");
      emit(
        state.copyWith(
          resetPasswordStatus: ResetPasswordStatus.sent,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

      emit(
        state.copyWith(resetPasswordStatus: ResetPasswordStatus.error),
      );
    }
  }

  void resetResetPasswordStatus() => emit(
        state.copyWith(resetPasswordStatus: ResetPasswordStatus.initial),
      );

//   void verifyUserEmail(String emailAddress) async {
//     //Emit processing state
//     emit(
//       state.copyWith(verificationStatus: VerificationStatus.processing),
//     );

//     // Send verifiction mail
//     try {
//       await accountRepository.verifyUserEmail(emailAddress);
//       // Start stream every 500 milliseconds to see if email has been verified
//       accountRepository.hasBeenVerifiedStream().listen(
//         (event) {
//           //If email has been verified update Verified UI status and
//           // update isVerified in user object
//           if (event == true) {
//             emit(
//               state.copyWith(
//                 verificationStatus: VerificationStatus.verified,
//                 user: state.user?.copyWith(isVerified: true),
//               ),
//             );
//             throw Error(); //to cancel the stream
//           }
//         },
//         cancelOnError: true,
//       );
//     } catch (e, s) {
//       if (kDebugMode) {
//         print(e);
//         print(s);
//       }
//       emit(
//         state.copyWith(
//           verificationStatus: VerificationStatus.error,
//         ),
//       );
//     }
//   }
}
