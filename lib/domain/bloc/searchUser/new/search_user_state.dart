part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserState {}

class SearchUserInitial extends SearchUserState {}


class SearchUserLoadingState extends SearchUserState {}

class SearchUserFinishedState extends SearchUserState {
  final List<SearchUserData> searchUserList;

  SearchUserFinishedState(this.searchUserList);
}

class SearchUserStateErrorState extends SearchUserState {
  final String? message;

  SearchUserStateErrorState(this.message);
}


class ClearUserSearchState extends SearchUserState{

}