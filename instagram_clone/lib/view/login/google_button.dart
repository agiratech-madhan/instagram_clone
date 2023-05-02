import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/constants/strings.dart';
import '../constants/app_color.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.google,
            color: AppColors.googleColor,
          ),
          SizedBox(
            width: 10,
          ),
          const Text(Strings.google)
        ],
      ),
    );
  }
}
