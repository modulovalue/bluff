import '../../base/color.dart';
import '../../base/keys.dart';
import '../../base/locale.dart';
import '../../base/text.dart';
import '../../css/impl/builder.dart';
import '../../css/interface/css.dart';
import '../../html/impl/html.dart';
import '../../html/interface/html.dart';
import '../theme/theme.dart';
import '../widget/impl/widget_mixin.dart';
import '../widget/interface/build_context.dart';
import '../widget/interface/widget.dart';

class Text implements Widget {
  @override
  final Key? key;

  /// The text to display.
  ///
  /// This will be null if a textSpan is provided instead.
  final String data;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing DefaultTextStyle. Otherwise, the style will
  /// replace the closest enclosing DefaultTextStyle.
  final TextStyle? style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient Directionality, if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See RenderParagraph.locale for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the MediaQueryData.textScaleFactor obtained from the ambient
  /// MediaQuery, or 1.0 if there is no MediaQuery in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient DefaultTextStyle that specifies
  /// an explicit number for its DefaultTextStyle.maxLines, then the
  /// DefaultTextStyle value will take precedence. You can use a RichText
  /// widget directly to entirely override the DefaultTextStyle.
  final int? maxLines;

  /// Creates a text widget.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing DefaultTextStyle.
  ///
  /// The [data] parameter must not be null.
  const Text(
    this.data, {
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.key,
  });

  @override
  HtmlElement2 renderHtml(BuildContext context) {
    final lines = data.split('\n');
    return ParagraphElement2Impl()
      ..childNodes.addAll(
        [
          RawTextElement2Impl(lines.first),
          // if (lines.length > 1) ...lines.skip(1).expand((x) => [BRElement2Impl(), TextElement2Impl(x)]),
        ],
      );
  }

  @override
  CssStyleDeclaration2 renderCss(BuildContext context) {
    final style = CssStyleDeclaration2BuilderImpl();
    final textStyles = this.style ?? Theme.of(context)!.text.paragraph;
    if (textAlign != null) {
      switch (textAlign!) {
        case TextAlign.end:
          // TODO is this correct?
          style.textAlign = 'right';
          break;
        case TextAlign.right:
          style.textAlign = 'right';
          break;
        case TextAlign.center:
          style.textAlign = 'center';
          break;
        case TextAlign.left:
          style.textAlign = 'left';
          break;
        case TextAlign.justify:
          // TODO is this correct?
          style.textAlign = 'left';
          break;
        case TextAlign.start:
          // TODO: is this correct?
          style.textAlign = 'left';
          break;
      }
    }
    if (textStyles.height != null) {
      style.lineHeight = '${textStyles.height}';
    }
    style.display = 'flex';
    style.fontSize = (textStyles.fontSize ?? 12).toString();
    style.color = (textStyles.color ?? const Color(0xFF000000)).toCss();
    style.fontWeight = const <int, String>{
      0: '100',
      1: '200',
      2: '300',
      3: '400',
      4: '500',
      5: '600',
      6: '700',
      7: '800',
      8: '900',
    }[textStyles.fontWeight?.index ?? FontWeight.w400.index];
    style.fontFamily = <String>[
      if (textStyles.fontFamily != null) "'" + textStyles.fontFamily! + "'",
      if (textStyles.fontFamilyFallback != null) ...textStyles.fontFamilyFallback!
    ].join(', ');
    return style;
  }

  @override
  HtmlElement2 render(BuildContext context) => renderWidget(this, context);
}
