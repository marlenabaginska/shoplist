import 'package:shoplist/app/models/user_model.dart';

abstract class AuthProvider {
  UserModel? get currentUser;
  Future<UserModel> logIn({
    required String email,
    required String password,
  });
  Future<UserModel> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
}
