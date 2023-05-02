// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'base_text.dart';

// import '';S
@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({required super.text, required this.onTapped, super.style});
}
