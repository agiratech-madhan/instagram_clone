import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/backend/authenticator.dart';
import 'package:instagram_clone/state/auth/provider/auth_state_provider.dart';
import 'package:instagram_clone/state/auth/provider/is_logged_in_provider.dart';
import 'package:instagram_clone/state/provider/is_loading_provider.dart';
import 'package:instagram_clone/view/components/loading/loading_screen.dart';
import 'package:instagram_clone/view/login/login_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    ref.listen(isLoadingProvider, (_, isLoading) {
      if (isLoading) {
        return LoadingScreen.instance().show(context: context);
      } else {
        return LoadingScreen.instance().hide();
      }
    });

    return MaterialApp(
        title: 'Flutter De mo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            indicatorColor: Colors.blueGrey),
        themeMode: ThemeMode.dark,
        home: isLoggedIn ? MainView() : LoginView());
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main View"),
        centerTitle: true,
      ),
      body: Consumer(builder: ((_, ref, child) {
        return TextButton(
          onPressed: () async {
            // LoadingScreen.instance().show(context: context, text: 'Loading...');

            ref.read(authStateProvier.notifier).logout();
          },
          child: Text(
            "Logout",
          ),
        );
      })),
    );
  }
}

// class LoginView extends ConsumerWidget {
//   const LoginView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login View"),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: ref.read(authStateProvier.notifier).loginWithGoogle,
//             child: const Text("Sign In With Google"),
//           ),
//           TextButton(
//             onPressed: ref.read(authStateProvier.notifier).loginwithFacebook,
//             child: const Text("Sign In With Facebook"),
//           ),
//         ],
//       ),
//     );
//   }
// }
