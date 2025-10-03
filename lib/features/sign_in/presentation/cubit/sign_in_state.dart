import 'package:flutter/material.dart';
import 'package:lavender/features/sign_in/data/models/user_model.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}

final class SigninSuccess extends SigninState {
 final UserModel user;

 SigninSuccess({required this.user});
}

final class SigninError extends SigninState {
  final String message;

  SigninError(this.message);
}

final class SignOutLoading extends SigninState {}

final class SignOutSuccess extends SigninState {}

final class SignOutError extends SigninState {
  final String message;

  SignOutError(this.message);
}
