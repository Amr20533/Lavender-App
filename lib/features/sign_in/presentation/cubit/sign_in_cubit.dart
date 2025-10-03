import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavender/features/sign_in/logic/use_cases/sign_in_usecase.dart';
import 'package:lavender/features/sign_in/logic/use_cases/sign_out_use_case.dart';
import 'package:lavender/features/sign_in/presentation/cubit/sign_in_state.dart';


class SignInCubit extends Cubit<SigninState> {
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  SignInCubit(this.signInUseCase, this.signOutUseCase) : super(SigninInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    try {
      print("Attempting login with $email / $password");
      final user = await signInUseCase(
        SignInParams(
          email: email.trim(),
          password: password.trim(),
        ),
      );
      print(" رجع من اليوزر كيس: $user");
      emit(SigninSuccess(user: user));
    } catch (e) {
      emit(SigninError("حدث خطأ: ${e.toString()}"));
    }
  }
  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      await signOutUseCase();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError("خطأ أثناء تسجيل الخروج: ${e.toString()}"));
    }
  }

}
