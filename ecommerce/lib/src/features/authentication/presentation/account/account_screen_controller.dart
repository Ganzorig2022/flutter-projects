import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';

// using new syntax using the riverpor generator
@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {}

  Future<bool> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
    return state.hasError == false;
  }
}
