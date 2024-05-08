import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue-class.html
// AsyncValue ==> A utility for safely manipulating asynchronous data.
class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  final FakeAuthRepository authRepository;

  Future<bool> signOut() async {
    // OPTION #1. Using try-catch
    // try {
    //   state = const AsyncValue<void>.loading();
    //   await authRepository.signOut();
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (error, stackTrace) {
    //   state = AsyncValue<void>.error(error, stackTrace);
    //   return false;
    // }

    // OPTION #2. AsyncGuard method
    // https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue/guard.html
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
    return state.hasError == false;
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
