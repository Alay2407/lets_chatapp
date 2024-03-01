part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupFinishedState extends SignupState {

  final SignupResponse? signupResponse;

  SignupFinishedState(this.signupResponse);

}
class SignupErrorState extends SignupState {
  final String message;

  SignupErrorState(this.message);
}