import '../html/impl/html.dart';
import '../html/interface/html.dart';
import '../widgets/builder/builder.dart';
import '../widgets/localization/localizations.dart';
import '../widgets/theme/theme.dart';
import '../widgets/widget/impl/widget_mixin.dart';
import '../widgets/widget/interface/build_context.dart';
import '../widgets/widget/interface/widget.dart';
import 'breakpoint.dart';
import 'keys.dart';
import 'locale.dart';
import 'media_query_data.dart';

class Application with WidgetMixin {
  final String? currentRoute;
  final List<WidgetRoute> routes;
  final List<MediaSize> availableSizes;
  final List<Locale> supportedLocales;
  final List<MetaElement2> additionalMeta;
  final List<void Function(Application application, HtmlHtmlElement2 document)> plugins;
  final List<String> stylesheetLinks;
  final List<String> scriptLinks;
  final ThemeData Function(BuildContext context)? theme;
  final Widget Function(BuildContext context, WidgetRoute child)? builder;
  final void Function(BuildContext context, HtmlHtmlElement2 html)? postRender;
  @override
  final Key? key = null;

  /// This list collectively defines the localized resources objects that can
  /// be retrieved with [Localizations.of].
  final List<LocalizationsDelegate<dynamic>> delegates;

  Application({
    required this.routes,
    this.currentRoute,
    this.theme,
    this.builder,
    this.postRender,
    this.additionalMeta = const <MetaElement2>[],
    this.stylesheetLinks = const <String>[],
    this.scriptLinks = const <String>[],
    this.plugins = const <void Function(Application application, HtmlHtmlElement2 document)>[],
    this.delegates = const <LocalizationsDelegate<dynamic>>[],
    this.supportedLocales = const <Locale>[
      Locale('en', 'US'),
    ],
    List<MediaSize> availableSizes = MediaSize.values,
  })  : assert(availableSizes.isNotEmpty, "Given availableSize can't be empty."),
        availableSizes = <MediaSize>[...availableSizes]..sort((x, y) => x.index.compareTo(y.index));

  Application withCurrentRoute(
    String currentRoute,
  ) =>
      Application(
        routes: routes,
        currentRoute: currentRoute,
        theme: theme,
        stylesheetLinks: stylesheetLinks,
        scriptLinks: scriptLinks,
        plugins: plugins,
        delegates: delegates,
        supportedLocales: supportedLocales,
        availableSizes: availableSizes,
        builder: builder,
        additionalMeta: additionalMeta,
        postRender: postRender,
      );

  String _mediaClassForMediaSize(MediaSize size) {
    final availableIndex = availableSizes.indexOf(size);
    final min = availableIndex == 0 ? Breakpoint(size, 0) : Breakpoint.defaultBreakpoint(size);
    final max = availableIndex + 1 >= availableSizes.length ? null : Breakpoint.defaultBreakpoint(availableSizes[availableIndex + 1]);
    final minString = '(min-width: ${min.minSize}px)';
    final maxString = max == null ? '' : ' and (max-width: ${max.minSize - 1}px)';
    final buffer = StringBuffer();
    buffer.write('@media all and $minString$maxString {');
    for (final current in availableSizes) {
      buffer.write('.size${current.index} {display: ${size == current ? "block" : "none"}; } ');
    }
    buffer.write('}');
    return buffer.toString();
  }

  @override
  HtmlElement2 renderHtml(BuildContext context) {
    final document = HtmlHtmlElement2Impl();
    final currentRoute = routes.firstWhere((x) => x.relativeUrl == this.currentRoute);
    final head = HeadElement2Impl();
    head.childNodes.add(MetaElement2Impl()..setAttribute('charset', 'UTF-8'));
    head.childNodes
        .add(MetaElement2Impl()..setAttribute('name', 'viewport')..setAttribute('content', 'width=device-width, initial-scale=1'));
    head.childNodes.addAll(additionalMeta);
    document.childNodes.add(head);
    for (final link in stylesheetLinks) {
      final linkElement = LinkElement2Impl();
      linkElement.href = link;
      linkElement.rel = 'stylesheet';
      head.childNodes.add(linkElement);
    }
    currentRoute.head(context, head);
    final styles = StyleElement2Impl();
    styles.childNodes.add(TextElement2Impl(resetCss));
    styles.childNodes.add(TextElement2Impl(baseCss));
    document.childNodes.add(styles);
    final body = BodyElement2Impl();
    document.childNodes.add(body);
    for (final mediaSize in availableSizes) {
      styles.childNodes.add(TextElement2Impl(_mediaClassForMediaSize(mediaSize)));
      final sizeDiv = DivElement2Impl();
      sizeDiv.className = 'size' + mediaSize.index.toString();
      final root = MediaQuery(
        data: MediaQueryDataImpl(size: mediaSize),
        child: Builder(
          builder: (context) => Theme(
            data: theme?.call(context),
            child: builder != null ? builder!(context, currentRoute) : currentRoute.builder(context),
          ),
        ),
      );
      sizeDiv.childNodes.add(root.render(context));
      body.childNodes.add(sizeDiv);
      for (final link in scriptLinks) {
        body.childNodes.add(ScriptElement2Impl()
          ..src = link
          ..async = true
          ..defer = true);
      }
    }
    postRender?.call(context, document);
    return document;
  }

  @override
  HtmlElement2 render(BuildContext context) {
    final result = super.render(context);
    final styles = result.childNodes.firstWhere((x) => x is StyleElement);
    context.styles.entries.forEach((e) {
      styles.childNodes.add(TextElement2Impl('.${e.key} { ${e.value.toString()} }'));
    });
    for (final plugin in plugins) {
      plugin(this, result as HtmlHtmlElement2Impl);
    }
    return result;
  }
}

class WidgetRoute {
  final String Function(BuildContext context) title;
  final String relativeUrl;
  final Widget Function(BuildContext context) builder;

  const WidgetRoute({
    required this.title,
    required this.relativeUrl,
    required this.builder,
  });

  void head(BuildContext context, HeadElement2Impl head) => //
      head.childNodes.add(TitleElement2Impl()..text = title(context));

  HtmlElement2 renderHtml(BuildContext context) => //
      builder(context).render(context);
}

const baseCss = '''
.click {
  display: flex;
}

.click .active {
  display: none;
}
.click .inactive {
  display: flex;
}
.click .hover {
  display: none;
}

.click:active .active {
  display: flex;
}
.click:active .inactive {
  display: none;
}
.click:active .hover {
  display: none;
}

.click:hover .active {
  display: none;
}
.click:hover .inactive {
  display: none;
}
.click:hover .hover {
  display: flex;
  cursor: pointer;
}
''';
const resetCss = '''
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}
a {
  text-decoration: none;
}
''';
