import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/view/components/constants/strings.dart';
import 'package:instagram_clone/view/login/divider_maegins.dart';
import 'package:instagram_clone/view/login/login_view_sign_up_links.dart';

import '../../state/provider/is_loading_provider.dart';
import '../components/loading/loading_screen.dart';
import '../constants/app_color.dart';
import 'face_book_button.dart';
import 'google_button.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(isLoadingProvider, (_, isLoading) {
      if (isLoading) {
        return LoadingScreen.instance().show(context: context);
      } else {
        return LoadingScreen.instance().hide();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(Strings.welcomeToAppName,
                  style: Theme.of(context).textTheme.displaySmall),
              const DividerWithMargin(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed:
                    ref.read(authStateProvider.notifier).loginwithFacebook,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const FacebookButton(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const GoogleButton(),
              ),
              const DividerWithMargin(),
              const LoginViewSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}
