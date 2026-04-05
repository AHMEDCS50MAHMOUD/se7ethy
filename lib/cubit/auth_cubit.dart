import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../data/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  loginWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.loginWithEmailAndPassword(
        emailAddress: emailAddress, password: password);

    if (response is UserCredential) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  registerWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.registerWithEmailAndPassword(
        emailAddress: emailAddress, password: password);

    if (response is UserCredential) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  signInWithGoogle() async {
    emit(AuthLoadingState());
    final response = await AuthRepo.signInWithGoogle();

    if (response is UserCredential) {
      emit(AuthSuccessState() );
    } else {
      emit(AuthErrorState());
    }
  }
}
