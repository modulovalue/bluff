import '../../css/interface/builder.dart';

export 'package:universal_html/src/html.dart';

/// TODO diy html types serialization and remove universal_html dependency.

abstract class HtmlElement2 {
  abstract String? className;
  abstract String? id;

  CssStyleDeclaration2Builder get style;

  List<HtmlElement2> get childNodes;

  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a);
}

abstract class DivElement2 implements HtmlElement2 {}

abstract class HeadElement2 implements HtmlElement2 {}

abstract class MetaElement2 implements HtmlElement2 {
  void forEachAttribute(void Function(String key, String value) fn);

  void setAttribute(String key, String value);
}

abstract class BodyElement2 implements HtmlElement2 {}

abstract class StyleElement2 implements HtmlElement2 {}

abstract class ScriptElement2 implements HtmlElement2 {
  abstract String? src;
  abstract bool? async;
  abstract bool? defer;
}

abstract class LinkElement2 implements HtmlElement2 {
  abstract String? href;
  abstract String? rel;
}

abstract class TitleElement2 implements HtmlElement2 {
  abstract String? text;
}

abstract class HtmlHtmlElement2 implements HtmlElement2 {}

abstract class TextElement2 implements HtmlElement2 {
  String get text;
}

abstract class BRElement2 implements HtmlElement2 {}

abstract class ParagraphElement2 implements HtmlElement2 {}

abstract class ImageElement2 implements HtmlElement2 {
  abstract String? src;
  abstract String? alt;
}

abstract class AnchorElement2 implements HtmlElement2 {
  abstract String? href;
  abstract String? target;
}

abstract class HtmlElementVisitorOneArg<R, A> {
  R visitDiv(DivElement2 div, A arg); //
  R visitHead(HeadElement2 div, A arg); //
  R visitMeta(MetaElement2 div, A arg); //
  R visitBody(BodyElement2 div, A arg); //
  R visitStyle(StyleElement2 div, A arg); //
  R visitScript(ScriptElement2 div, A arg); //
  R visitLink(LinkElement2 div, A arg); //
  R visitTitle(TitleElement2 div, A arg); //
  R visitHtmlHtml(HtmlHtmlElement2 div, A arg); //
  R visitText(TextElement2 div, A arg); //
  R visitBr(BRElement2 div, A arg); //
  R visitParagraph(ParagraphElement2 div, A arg); //
  R visitImage(ImageElement2 div, A arg); //
  R visitAnchor(AnchorElement2 div, A arg); //
}
