import '../assets.dart';
import '../html.dart' as html;
import 'base/keys.dart';

abstract class Widget {
  Key? get key;

  html.HtmlElement render(BuildContext context);

  html.HtmlElement renderHtml(BuildContext context);

  html.CssStyleDeclaration? renderCss(BuildContext context);
}

class BuildContext {
  static int lastKeyIndex = 0;
  final Map<Type, InheritedWidget> _inheritedWidgets = {};
  final Map<String, html.CssStyleDeclaration> styles;
  final Assets assets;

  BuildContext({
    required this.assets,
    Map<String, html.CssStyleDeclaration>? styles,
  }) : styles = styles ?? <String, html.CssStyleDeclaration>{};

  BuildContext withInherited(InheritedWidget widget) => BuildContext(
        styles: styles,
        assets: assets,
      )
        .._inheritedWidgets.addAll(_inheritedWidgets)
        .._inheritedWidgets[widget.runtimeType] = widget;

  Key createDefaultKey() => Key('_w${lastKeyIndex++}');

  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() {
    assert(
      _inheritedWidgets.containsKey(T),
      'No inherited widget with type $T found in tree',
    );
    return _inheritedWidgets[T] as T?;
  }
}

abstract class InheritedWidget with WidgetMixin {
  final Widget child;
  final Key? key;

  const InheritedWidget({
    required this.child,
    this.key,
  });

  @override
  html.HtmlElement renderHtml(BuildContext context) => child.render(context);

  @override
  html.HtmlElement render(BuildContext context) => super.render(context.withInherited(this));
}

mixin WidgetMixin implements Widget {
  @override
  html.HtmlElement render(BuildContext context) {
    final widget = this;
    final css = widget.renderCss(context);
    final html = widget.renderHtml(context);
    final k = widget.key;
    if (k != null) {
      final media = MediaQuery.of(context);
      html.id = k.className + '-${media!.size.index}';
    }
    final key = context.createDefaultKey();
    html.className = html.className! + (html.className!.isEmpty ? '' : ' ') + key.className;
    if (css != null) context.styles[key.className] = css;
    return html;
  }

  @override
  html.CssStyleDeclaration? renderCss(BuildContext context) => null;
}

class MediaQuery extends InheritedWidget {
  final MediaQueryData data;

  const MediaQuery({
    required Widget child,
    required this.data,
    Key? key,
  }) : super(key: key, child: child);

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

enum MediaSize { xsmall, small, medium, large, xlarge }
