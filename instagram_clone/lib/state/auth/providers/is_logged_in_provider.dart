import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/models/auth_result.dart';
import 'package:instagram_clone/state/auth/provider/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
    (ref) => ref.watch(authStateProvier).result == AuthResult.success);
