import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:retrofit/retrofit.dart';

abstract class LoginRepository {
  Future<LoginData> login(
      String email,
      String password,
      );
}
