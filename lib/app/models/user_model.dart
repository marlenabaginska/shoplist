import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String? email;
  final String uid;

  const UserModel({
    required this.email,
    required this.uid,
  });

  factory UserModel.fromFirebase(User user) => UserModel(
        email: user.email,
        uid: user.uid,
      );
}
