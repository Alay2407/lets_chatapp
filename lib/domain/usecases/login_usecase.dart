import 'package:lets_chatapp/core/usecases/loginBase_usecase.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import '../../data/repository_impl/login_repository_impl.dart';

class LoginUseCase extends LoginBaseUsecase {
  LoginRepositoryImpl loginRepositoryImpl;

  LoginUseCase(this.loginRepositoryImpl);

  @override
  Future<LoginData> call(String email, String password) async {
    return await loginRepositoryImpl.login(
      email,
      password,
    );
  }
}
