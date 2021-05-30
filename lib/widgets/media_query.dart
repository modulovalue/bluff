import 'package:bluff/base/keys.dart';

import '../build_context.dart';
import 'widget.dart';

class MediaQuery extends InheritedWidget {
  final MediaQueryData data;

  const MediaQuery({
    required Widget child,
    required this.data,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  static MediaQueryData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MediaQuery>()?.data;
  }
}

class MediaQueryData {
  final MediaSize size;

  const MediaQueryData({
    required this.size,
  });
}

enum MediaSize {
  xsmall,
  small,
  medium,
  large,
  xlarge,
}
