// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/auth/models/auth_result.dart';

import '../../posts/typedefs/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;
  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });
  const AuthState.unKnown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoadings) =>
      AuthState(isLoading: isLoadings, result: result, userId: userId);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
