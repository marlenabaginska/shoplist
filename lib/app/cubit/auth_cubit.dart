import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shoplist/app/models/user_model.dart';
import 'package:shoplist/app/repositories/firebase_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseAuthRespository)
      : super(
          const AuthState(
            user: null,
          ),
        );

  StreamSubscription? _streamSubscription;

  final FirebaseAuthRespository _firebaseAuthRespository;

  Future<void> start() async {
    emit(
      const AuthState(
        user: null,
      ),
    );
    _streamSubscription =
        _firebaseAuthRespository.getInstance.authStateChanges().listen(
      (user) {
        if (user != null) {
          final userModel = UserModel.fromFirebase(user);
          emit(
            AuthState(
              user: userModel,
            ),
          );
        } else {
          emit(
            const AuthState(
              user: null,
            ),
          );
        }
      },
    )..onError((error) {
            emit(
              const AuthState(
                user: null,
              ),
            );
          });
  }

  Future<void> createUser({
    required final String email,
    required final String password,
  }) async {
    _firebaseAuthRespository.createUser(
      email: email,
      password: password,
    );
  }

  Future<void> logIn({
    required final String email,
    required final String password,
  }) async {
    _firebaseAuthRespository.logIn(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    _firebaseAuthRespository.logOut();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
