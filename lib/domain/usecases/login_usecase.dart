import 'package:lets_chatapp/core/usecases/loginBase_usecase.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/data/repository_impl/authRepository_impl.dart';

class LoginUseCase extends LoginBaseUsecase {
  AuthRepositoryimpl authRepositoryimpl;

  LoginUseCase(this.authRepositoryimpl);

  @override
  Future<LoginData> call(String email, String password) async {
    return await authRepositoryimpl.login(
      email,
      password,
    );
  }
}
