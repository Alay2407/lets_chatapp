part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}

class LoginFinishedState extends LoginState {

  final LoginData? loginData;

  LoginFinishedState(this.loginData);

}
class LoginErrorState extends LoginState {
  final String? message;

  LoginErrorState(this.message);
}