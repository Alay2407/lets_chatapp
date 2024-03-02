import 'package:lets_chatapp/data/Model/authModel/login_data.dart';

abstract class LoginRepository {
  Future<LoginData> login(
      String email,
      String password,
      );
}
