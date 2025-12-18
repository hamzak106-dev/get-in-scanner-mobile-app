import 'package:g_e_t_i_n_scanner/flutter_flow/firebase_remote_config_util.dart';

String? resolveProfileImage(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return null; // Default image URL
  }
  if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
    return imageUrl; // Already a full URL
  }
  return getRemoteConfigString("ImageBaseUrl") + '/profile/' + imageUrl;
}
