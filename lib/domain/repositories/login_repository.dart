import 'package:lets_chatapp/data/Model/authModel/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(
      String email,
      String password,
      );
}
