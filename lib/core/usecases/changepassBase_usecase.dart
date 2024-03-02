abstract class ChangepassBaseUsecase<T> {
  Future<T> call(
      String currentPassword,
      String newPassword,
      );
}
