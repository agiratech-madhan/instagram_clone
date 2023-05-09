import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/providers/post_setting_provider.dart';
import 'package:instagram_clone/view/components/dialogs/alert_dialog_model.dart';
import '../../state/auth/provider/auth_state_provider.dart';
import '../../state/image_upload/helper/image_picker_helper.dart';
import '../../state/image_upload/models/file_type.dart';
import '../components/constants/strings.dart';
import '../components/dialogs/logout_dialog.dart';
import '../create_new_post/create_new_post_view.dart';
import '../tabs/search/search_view.dart';
import '../tabs/user_posts/user_posts_view.dart';

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
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }

                ref.refresh(PostSettingProvider);
                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileType: FileType.video,
                      fileToPost: videoFile,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (videoFile == null) {
                  return;
                }

                ref.refresh(PostSettingProvider);
                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileType: FileType.image,
                      fileToPost: videoFile,
                    ),
                  ),
                );
              },
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
                  ref.read(authStateProvider.notifier).logOut();
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
        body: const TabBarView(
          children: [
            UserPostsView(),
            SearchView(),
            UserPostsView(),
            // SearchView(),
            // HomeView(),
          ],
        ),
      ),
    );
  }
}
