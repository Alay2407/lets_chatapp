import 'package:lets_chatapp/core/usecases/signupBase_usecase.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/data/repository_impl/authRepository_impl.dart';

class SignupUsecase extends SignupBaseUsecase {
  AuthRepositoryimpl authRepositoryimpl;

  SignupUsecase(this.authRepositoryimpl);

  @override
  Future<SignupResponse> call(String name, String email, String password, String confirmPassword) async {
    return await authRepositoryimpl.signUp(
      name,
      email,
      password,
      confirmPassword,
    );
  }
}
