import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/view/components/dialogs/alert_dialog_model.dart';

import '../../state/auth/provider/auth_state_provider.dart';
import '../../state/auth/providers/auth_state_provider.dart';
import '../components/constants/strings.dart';
import '../components/dialogs/logout_dialog.dart';
import '../tabs/user_posts/user_posts_view.dart';

// class MainView extends StatelessWidget {
//   const MainView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Main View"),
//         centerTitle: true,
//       ),
//       body: Consumer(builder: ((_, ref, child) {
//         return
//             //  EmptyContentWithTextAnimationView(
//             //   text: "Hello World",
//             // );
//             TextButton(
//           onPressed: () async {
//             // LoadingScreen.instance().show(context: context, text: 'Loading...');

//             await ref.read(authStateProvier.notifier).logOut();
//           },
//           child: Text(
//             "Logout",
//           ),
//         );
//       })),
//     );
//   }
// }

class MainView extends StatefulHookConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {},
            ),
            IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await LogoutDialog().present(context).then(
                      (value) => value ?? false,
                    );
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
            // SearchView(),
            // HomeView(),
          ],
        ),
      ),
    );
  }
}
// class  extends StatefulHookConsumerWidget {
//   const ({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _State();
// }
// class _State extends ConsumerState<> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }