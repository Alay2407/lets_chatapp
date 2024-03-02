part of 'changepass_bloc.dart';

@immutable
abstract class ChangepassState {}

class ChangepassInitial extends ChangepassState {}

class ChangepassLoadingState extends ChangepassState {}

class ChangepassFinishedState extends ChangepassState {
  final LoginData? loginData;

  ChangepassFinishedState(this.loginData);
}

class ChangepassErrorState extends ChangepassState {
  final String? message;

  ChangepassErrorState(this.message);
}
