part of 'changepass_bloc.dart';

@immutable
abstract class ChangepassEvent {}

class ChangepassSuccess extends ChangepassEvent {}

class Changepass extends ChangepassEvent {
  final String currentPassword, newPassword;

  Changepass({
    required this.currentPassword,
    required this.newPassword,
  });
}
