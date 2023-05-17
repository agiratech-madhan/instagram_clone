import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/is_logged_in_provider.dart';
import 'package:instagram_clone/state/provider/is_loading_provider.dart';
import 'package:instagram_clone/view/components/loading/loading_screen.dart';
import 'package:instagram_clone/view/login/login_view.dart';
import 'package:instagram_clone/view/main/main_view.dart';
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

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<bool>(
    //   isLoadingProvider,
    //   (_, isLoading) {
    //     if (isLoading) {
    //       // return LoadingScreen.instance().show(
    //       //   context: context,
    //       // );
    //       const CircularProgressIndicator();
    //     } else {
    //       // return LoadingScreen.instance().hide();
    //     }
    //   },
    // );
    return MaterialApp(
        // title: 'Flutter De mo',
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
        home: HookConsumer(builder: ((__, ref, child) {
          ref.listen(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              return LoadingScreen.instance().show(context: __);
            } else {
              return LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        })));

    // isLoggedIn ? MainView() : LoginView());
  }
}
