import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DividerWithMargin extends StatelessWidget {
  const DividerWithMargin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 40,
        ),
        Divider(),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
