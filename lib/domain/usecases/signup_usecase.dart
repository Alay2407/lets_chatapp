import 'package:lets_chatapp/core/usecases/signupBase_usecase.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';

import '../../data/repository_impl/singup_repository_impl.dart';

class SignupUsecase extends SignupBaseUsecase {
  SignupRepositoryImpl signupRepositoryImpl;

  SignupUsecase(this.signupRepositoryImpl);

  @override
  Future<SignupResponse> call(String name, String email, String password, String confirmPassword) async {
    return await signupRepositoryImpl.signUp(
      name,
      email,
      password,
      confirmPassword,
    );
  }
}
