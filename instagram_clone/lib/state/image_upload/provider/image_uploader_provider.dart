import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/notifier/image_upload_notifier.dart';

import '../typedef/is_loading_typedef.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, LoadingState>(
        (ref) => ImageUploadNotifier());
