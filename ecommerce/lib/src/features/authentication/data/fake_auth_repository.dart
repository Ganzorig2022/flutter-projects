import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;

  AppUser? get currentUser => null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _authState.value = AppUser(uid: uuid.v4(), email: '');
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {}

  Future<void> signOut(String email, String password) async {}
}

final authRepositoryProvider = Provider<FakeAuthRepository>(
  (ref) {
    return FakeAuthRepository();
  },
);

final authStateChangeProvider = StreamProvider<AppUser?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return authRepository.authStateChanges();
  },
);
