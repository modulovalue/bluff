import '../../css/impl/builder.dart';
import '../interface/html.dart';

mixin HtmlElementMixin implements HtmlElement2 {
  @override
  String? className;
  @override
  String? id;
  @override
  final List<HtmlElement2> childNodes = [];
  @override
  final CssStyleDeclaration2BuilderImpl style = CssStyleDeclaration2BuilderImpl();
}

class BRElement2Impl with HtmlElementMixin implements BRElement2 {
  BRElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitBr(this, a);
}

class HtmlHtmlElement2Impl with HtmlElementMixin implements HtmlHtmlElement2 {
  HtmlHtmlElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitHtmlHtml(this, a);
}

class MetaElement2Impl with HtmlElementMixin implements MetaElement2 {
  final Map<String, String> attributes = {};

  MetaElement2Impl();

  @override
  void setAttribute(String key, String value) {
    attributes[key] = value;
  }

  @override
  void forEachAttribute(
    void Function(String key, String value) fn,
  ) =>
      attributes.forEach(fn);

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitMeta(this, a);
}

class BodyElement2Impl with HtmlElementMixin implements BodyElement2 {
  BodyElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitBody(this, a);
}

class TextElement2Impl with HtmlElementMixin implements TextElement2 {
  @override
  final String text;

  TextElement2Impl(this.text);

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitText(this, a);
}

class ScriptElement2Impl with HtmlElementMixin implements ScriptElement2 {
  @override
  bool? async;
  @override
  bool? defer;
  @override
  String? src;

  ScriptElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitScript(this, a);
}

class LinkElement2Impl with HtmlElementMixin implements LinkElement2 {
  @override
  String? href;
  @override
  String? rel;

  LinkElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitLink(this, a);
}

class TitleElement2Impl with HtmlElementMixin implements TitleElement2 {
  @override
  String? text;

  TitleElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitTitle(this, a);
}

class StyleElement2Impl with HtmlElementMixin implements StyleElement2 {
  StyleElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitStyle(this, a);
}

class ParagraphElement2Impl with HtmlElementMixin implements ParagraphElement2 {
  ParagraphElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitParagraph(this, a);
}

class ImageElement2Impl with HtmlElementMixin implements ImageElement2 {
  @override
  String? alt;
  @override
  String? src;

  ImageElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitImage(this, a);
}

class DivElement2Impl with HtmlElementMixin implements DivElement2 {
  DivElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitDiv(this, a);
}

class AnchorElement2Impl with HtmlElementMixin implements AnchorElement2 {
  @override
  String? href;
  @override
  String? target;

  AnchorElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitAnchor(this, a);
}

class HeadElement2Impl with HtmlElementMixin implements HeadElement2 {
  HeadElement2Impl();

  @override
  R accept<R, A>(HtmlElementVisitorOneArg<R, A> v, A a) => v.visitHead(this, a);
}
