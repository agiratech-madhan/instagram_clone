import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/post_settings.dart';
import 'package:instagram_clone/state/post_settings/notifier/post_settings_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>((ref) {
  return PostSettingNotifier();
});
