import 'package:lets_chatapp/core/usecases/changepassBase_usecase.dart';
import 'package:lets_chatapp/data/repository_impl/changepass_repository_impl.dart';

class ChangePassUsecase extends ChangepassBaseUsecase {
  ChangepassRepositoryImpl changepassRepositoryImpl;

  ChangePassUsecase(this.changepassRepositoryImpl);
  @override
  Future call(String currentPassword, String newPassword) async {
    return await changepassRepositoryImpl.changePassword(
      currentPassword,
      newPassword,
    );
  }
}
