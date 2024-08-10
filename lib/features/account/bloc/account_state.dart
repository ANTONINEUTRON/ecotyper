import 'package:equatable/equatable.dart';
import 'package:ecotyper/features/account/data/model/user.dart';
import 'package:ecotyper/shared/exception/tn_exception.dart';

enum AccountStatus {
  signedIn,
  processing,
  signedOut,
  signInError,
  authHandlerException
}

enum UpdateAccountStatus { initial, updated, processing, error }

enum UpdatePasswordStatus {
  initial,
  updated,
  processing,
  error,
  oldPasswordNotMatch
}

enum ResetPasswordStatus { initial, processing, error, sent }

enum UploadPPStatus { initial, uploaded, processing, error, fileNotSelected }

class AccountState extends Equatable {
  const AccountState({
    this.user,
    this.password,
    this.accountStatus = AccountStatus.signedOut,
    this.updateAccountStatus = UpdateAccountStatus.initial,
    this.resetPasswordStatus = ResetPasswordStatus.initial,
    this.uploadPPStatus = UploadPPStatus.initial,
    this.updatePasswordStatus = UpdatePasswordStatus.initial,
    this.authHandlerException,
  });

  final User? user;
  final String? password;
  final AccountStatus accountStatus;
  final UpdateAccountStatus updateAccountStatus;
  final ResetPasswordStatus resetPasswordStatus;
  final UploadPPStatus uploadPPStatus;
  final UpdatePasswordStatus updatePasswordStatus;
  final AuthHandlerException? authHandlerException;

  @override
  List<Object?> get props => [
        user,
        accountStatus,
        password,
        updateAccountStatus,
        resetPasswordStatus,
        uploadPPStatus,
        updatePasswordStatus,
        authHandlerException,
      ];

  AccountState copyWith({
    User? user,
    AccountStatus? accountStatus,
    String? password,
    UpdateAccountStatus? updateAccountStatus,
    ResetPasswordStatus? resetPasswordStatus,
    UploadPPStatus? uploadPPStatus,
    UpdatePasswordStatus? updatePasswordStatus,
    AuthHandlerException? authHandlerException,
  }) {
    return AccountState(
      user: user ?? this.user,
      accountStatus: accountStatus ?? this.accountStatus,
      password: password ?? this.password,
      updateAccountStatus: updateAccountStatus ?? this.updateAccountStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      uploadPPStatus: uploadPPStatus ?? this.uploadPPStatus,
      updatePasswordStatus: updatePasswordStatus ?? this.updatePasswordStatus,
      authHandlerException: authHandlerException ?? this.authHandlerException,
    );
  }
}
