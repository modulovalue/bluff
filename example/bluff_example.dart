import 'package:bluff/app.dart';
import 'package:bluff/base/locale.dart';
import 'package:bluff/publish.dart';
import 'package:bluff/widgets/media_query.dart';

import 'routes/home.dart';

void main() {
  final app = Application(
    availableSizes: [
      MediaSize.small,
      MediaSize.medium,
    ],
    supportedLocales: [
      const Locale('fr', 'FR'),
      const Locale('en', 'US'),
    ],
    routes: [
      homeRoute,
    ],
  );
  publish(app);
}
