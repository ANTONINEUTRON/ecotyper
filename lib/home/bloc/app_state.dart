import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState({
    this.isSoundOn = false,
    this.isConnectedToInternet = false,
    this.notifyMessage,
  });
  final bool isSoundOn;
  final bool isConnectedToInternet;
  final String? notifyMessage;

  @override
  List<Object?> get props => [
        isSoundOn,
        isConnectedToInternet,
        notifyMessage,
      ];

  AppState copyWith({
    bool? isSoundOn,
    bool? isConnectedToInternet,
    String? notifyMessage,
  }) {
    return AppState(
      isSoundOn: isSoundOn ?? this.isSoundOn,
      isConnectedToInternet:
          isConnectedToInternet ?? this.isConnectedToInternet,
      notifyMessage: notifyMessage,
    );
  }
}
