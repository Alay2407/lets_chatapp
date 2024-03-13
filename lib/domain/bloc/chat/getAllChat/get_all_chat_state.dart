part of 'get_all_chat_cubit.dart';

@immutable
abstract class GetAllChatState {}
///Get All chat
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

///Get single chat
class GetSingleChatLoadingState extends GetAllChatState {}

class GetSingleChatFinishedState extends GetAllChatState {
  final GetSingleChat? getSingleChat;

  GetSingleChatFinishedState(this.getSingleChat);
}

class GetSingleChatErrorState extends GetAllChatState {
  final String? message;

  GetSingleChatErrorState(this.message);
}

///Get single User
class GetSingleUserLoadingState extends GetAllChatState {}

class GetSingleUserFinishedState extends GetAllChatState {
  final GetSingleUser? getSingleUser;

  GetSingleUserFinishedState(this.getSingleUser);
}

class GetSingleUserErrorState extends GetAllChatState {
  final String? message;

  GetSingleUserErrorState(this.message);
}
