import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';

abstract class SignUpRepository {
  Future<SignupResponse> signUp(
    String name,
    String email,
    String password,
    String confirmPassword
  );
}
