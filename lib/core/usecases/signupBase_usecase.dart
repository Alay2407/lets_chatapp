abstract class SignupBaseUsecase<T> {
  Future<T> call(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
}
