import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController(
      {required EmailPasswordSignInFormType formType,
      required this.authRepository})
      : super(EmailPasswordSignInState()); // function parameters

// declaring variables
  final FakeAuthRepository authRepository;

// #1. Submit async handler that returns boolean
  Future<bool> submit(String email, String password) async {
    state = state.copyWith(
      value: const AsyncValue.loading(),
    );
    final value = await AsyncValue.guard(() => _authenticate(email, password));
    return value.hasError == false;
  }

// #2. Login, signUp async handler
  Future<void> _authenticate(String email, String password) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

// #3. Updating the state
  void updateFormType(EmailPasswordSignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

// declaring the provider
final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);

  return EmailPasswordSignInController(
      authRepository: authRepository, formType: formType);
});
