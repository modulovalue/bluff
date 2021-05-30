import 'package:bluff/build_context.dart';
import 'package:path/path.dart' as path;

String resolveUrl(BuildContext context, String url) {
  if (url.startsWith('asset://')) {
    return path.join(context.assets.local.path, url.replaceAll('asset://', ''));
  }

  if (url.startsWith('#')) {
    final media = MediaQuery.of(context);
    return url + '-${media!.size.index}';
  }

  return url;
}
