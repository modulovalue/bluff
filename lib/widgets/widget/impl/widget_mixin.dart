import '../../../base/keys.dart';
import '../../../base/media_query_data.dart';
import '../../../css/interface/css.dart';
import '../../../html/interface/html.dart';
import '../interface/build_context.dart';
import '../interface/inherited_widget.dart';
import '../interface/widget.dart';

mixin WidgetMixin implements Widget {
  static HtmlElement2 renderWidget(Widget widget, BuildContext context) {
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
  HtmlElement2 render(BuildContext context) => //
      WidgetMixin.renderWidget(this, context);

  @override
  CssStyleDeclaration2? renderCss(BuildContext context) => null;
}

mixin InheritedWidgetMixin implements InheritedWidget {
  Widget get child;

  @override
  HtmlElement2 renderHtml(BuildContext context) => child.render(context);

  @override
  HtmlElement2 render(BuildContext context) => WidgetMixin.renderWidget(child, context.withInherited(this));

  @override
  CssStyleDeclaration2? renderCss(BuildContext context) => null;
}

class MediaQuery with InheritedWidgetMixin {
  final MediaQueryData data;
  @override
  final Key? key;
  @override
  final Widget child;

  const MediaQuery({
    required this.child,
    required this.data,
    this.key,
  });

  static MediaQueryData? of(BuildContext context) => //
      context.dependOnInheritedWidgetOfExactType<MediaQuery>()?.data;
}
