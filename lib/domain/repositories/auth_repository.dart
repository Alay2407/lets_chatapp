import '../../data/Model/authModel/login_data.dart';
import '../../data/Model/authModel/signup_response.dart';

abstract class AuthRepository{
  Future<LoginData> changePassword(String currentPassword, String newPassword);
  Future<LoginData> login(String email, String password);
  Future<SignupResponse> signUp(String name, String email, String password, String confirmPassword);
}