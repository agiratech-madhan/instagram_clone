import 'package:flutter/foundation.dart';
// ignore: unused_import
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Constants {
  static const accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
  const Constants._();
}
