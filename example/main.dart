import 'package:bluff/base/app.dart';
import 'package:bluff/base/border_radius.dart';
import 'package:bluff/base/color.dart';
import 'package:bluff/base/decoration.dart';
import 'package:bluff/base/edge_insets.dart';
import 'package:bluff/base/geometry.dart';
import 'package:bluff/base/image.dart';
import 'package:bluff/base/locale.dart';
import 'package:bluff/base/publish/impl/publish.dart';
import 'package:bluff/base/text.dart';
import 'package:bluff/widgets/click/click.dart';
import 'package:bluff/widgets/container/container.dart';
import 'package:bluff/widgets/flex/flex.dart';
import 'package:bluff/widgets/image/image.dart';
import 'package:bluff/widgets/localization/localizations.dart';
import 'package:bluff/widgets/padding/padding.dart';
import 'package:bluff/widgets/text/text.dart';
import 'package:bluff/widgets/theme/theme.dart';
import 'package:bluff/widgets/widget/interface/widget.dart';

void main() {
  publishApp(
    Application(
      supportedLocales: [
        const Locale('fr', 'FR'),
        const Locale('en', 'US'),
      ],
      routes: [
        WidgetRoute(
          title: (context) {
            final locale = Localizations.localeOf(context);
            if (locale!.languageCode == 'fr') {
              return 'Accueil';
            } else {
              return 'Home';
            }
          },
          relativeUrl: 'index',
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Hello world!'),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0000FF),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xAA0000FF),
                          blurRadius: 10,
                          offset: Offset(10, 10),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'images/logo_dart_192px.svg',
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      ...List.generate(5, (index) => const Text('Hello world!')),
                    ],
                  ),
                  Click(
                    newTab: true,
                    url: 'https://www.google.com',
                    builder: (context, state) => Container(
                      child: Text(
                        'Button',
                        style: Theme.of(context)!.text.paragraph.merge(
                              TextStyle(
                                color: state == ClickState.hover ? const Color(0xFFFFFFFF) : const Color(0xFF0000FF),
                              ),
                            ),
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: state == ClickState.hover ? const Color(0xFF0000FF) : const Color(0x440000FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
