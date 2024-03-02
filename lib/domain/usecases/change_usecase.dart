import 'package:lets_chatapp/core/usecases/changepassBase_usecase.dart';
import 'package:lets_chatapp/data/repository_impl/authRepository_impl.dart';

class ChangePassUsecase extends ChangepassBaseUsecase {
  AuthRepositoryimpl authRepositoryimpl;

  ChangePassUsecase(this.authRepositoryimpl);
  @override
  Future call(String currentPassword, String newPassword) async {
    return await authRepositoryimpl.changePassword(
      currentPassword,
      newPassword,
    );
  }
}
