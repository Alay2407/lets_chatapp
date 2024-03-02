import '../../data/Model/authModel/login_data.dart';

abstract class ChangepassRepository {
  Future<LoginData> changePassword(
      String currentPassword,
      String newPassword,
      );
}
