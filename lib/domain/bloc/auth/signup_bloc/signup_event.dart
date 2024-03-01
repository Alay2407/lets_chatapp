part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupSuccess extends SignupEvent {}


class SignupUser extends SignupEvent {
  final String name, email, password, confirmPassword;

  SignupUser(
      {
        required this.name,
        required this.email,
        required this.password,
        required this.confirmPassword,}
      );
}