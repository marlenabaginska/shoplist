import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:shoplist/app/models/user_model.dart';
import 'package:shoplist/app/repositories/user_repository.dart';

class FirebaseAuthRespository implements AuthProvider {
  FirebaseAuth getInstance = FirebaseAuth.instance;

  @override
  UserModel? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code.toString());
    }
  }

  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code.toString());
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
