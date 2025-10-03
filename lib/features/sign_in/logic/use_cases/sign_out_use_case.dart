import 'package:lavender/features/sign_up/logic/repositories_interface/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<void> call() {
    return authRepository.signOut();
  }
}
