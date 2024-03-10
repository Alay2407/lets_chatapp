part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserEvent {}


class FetchUsers extends SearchUserEvent{
  final String name;

   FetchUsers(this.name);
}

class ClearUserFromSearchtxt extends SearchUserEvent{

}