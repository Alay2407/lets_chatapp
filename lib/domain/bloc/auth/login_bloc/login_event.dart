part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSuccess extends LoginEvent {}

class LoginUser extends LoginEvent {
  final String email, password;

  LoginUser({
    required this.email,
    required this.password,
  });
}
