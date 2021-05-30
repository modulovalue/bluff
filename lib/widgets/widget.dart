import '../base/keys.dart';
import '../build_context.dart';
import '../html.dart' as html;

abstract class StatelessWidget with WidgetMixin {
  final Key? key;

  const StatelessWidget({this.key});

  Widget build(BuildContext context);

  @override
  html.HtmlElement renderHtml(BuildContext context) => build(context).render(context);
}

class Builder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  Builder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => builder(context);
}
