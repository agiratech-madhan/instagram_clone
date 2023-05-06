import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/auth_state_provider.dart';

import '../image_upload/provider/image_uploader_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadImage = ref.watch(imageUploadProvider);
  return authState.isLoading || isUploadImage;
});
