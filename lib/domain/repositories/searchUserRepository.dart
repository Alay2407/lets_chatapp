


import 'package:lets_chatapp/data/Model/user/searchUser/searchUserModel.dart';

abstract class SearchUserRepository{
  Future<SearchUserModel> searchUser(String name);
}