
class AuthRepository {

  Future<bool> signIn({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));

    if (username == '1' && password == '1') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }
}