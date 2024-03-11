part of 'send_message_cubit.dart';

@immutable
abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageFinishedState extends SendMessageState {
  final SendMessage? sendMessage;

  SendMessageFinishedState(this.sendMessage);
}

class SendMessageErrorState extends SendMessageState {
  final String? message;

  SendMessageErrorState(this.message);
}
