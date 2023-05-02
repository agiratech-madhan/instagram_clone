import 'dart:ui';

import 'package:instagram_clone/extensions/string/remove_all.dart';

extension AsHtmlColorToCOlor on String {
  Color htmlColorToColor() => Color(
        int.parse(
            removeAll(
              [
                '0x',
                '#',
              ],
            ).padLeft(8, 'ff'),
            radix: 16),
      );
}
