abstract class LoginBaseUsecase<T> {
  Future<T> call(
      String email,
      String password,
      );
}
