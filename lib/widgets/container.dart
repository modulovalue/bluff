import 'package:bluff/base/decoration.dart';
import 'package:bluff/base/edge_insets.dart';
import 'package:bluff/base/keys.dart';
import 'package:bluff/widgets/decorated_box.dart';
import 'package:bluff/widgets/sized_box.dart';
import 'package:bluff/widgets/widget.dart';

import '../build_context.dart';
import 'constrained_box.dart';
import 'padding.dart';

class Container extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  const Container({
    this.child,
    this.width,
    this.height,
    this.decoration,
    this.constraints,
    this.padding,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var result = child;
    if (padding != null) {
      result = Padding(
        child: result,
        padding: padding,
      );
    }
    if (decoration != null) {
      result = DecoratedBox(
        child: result,
        decoration: decoration,
      );
    }
    if (constraints != null) {
      result = ConstrainedBox(
        child: result,
        constraints: constraints,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: result,
    );
  }
}
