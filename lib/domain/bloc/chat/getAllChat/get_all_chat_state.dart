part of 'get_all_chat_cubit.dart';

@immutable
abstract class GetAllChatState {}

class GetAllChatInitial extends GetAllChatState {}

class GetAllChatLoadingState extends GetAllChatState {}

class GetAllChatFinishedState extends GetAllChatState {
  final GetAllChat? getAllChat;

  GetAllChatFinishedState(this.getAllChat);
}

class GetAllChatErrorState extends GetAllChatState {
  final String? message;

  GetAllChatErrorState(this.message);
}


class GetSingleChatFinishedState extends GetAllChatState {
  final GetSingleChat? getSingleChat;

  GetSingleChatFinishedState(this.getSingleChat);
}

class GetSingleChatErrorState extends GetAllChatState {
  final String? message;

  GetSingleChatErrorState(this.message);
}