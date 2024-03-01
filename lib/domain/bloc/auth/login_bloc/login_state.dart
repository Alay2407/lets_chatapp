part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}

class LoginFinishedState extends LoginState {

  final LoginResponse? loginResponse;

  LoginFinishedState(this.loginResponse);

}
class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}