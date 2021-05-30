import 'package:bluff/base/keys.dart';
import 'package:bluff/widgets/widget.dart';

import '../build_context.dart';

typedef ProviderCreator<T> = T Function(BuildContext context);

class Provider<T> extends StatelessWidget {
  final ProviderCreator<T> create;
  final Widget child;

  const Provider({
    required this.create,
    required this.child,
    Key? key,
  }) : super(key: key);

  static T? of<T>(BuildContext context) {
    return ValueProvider.of<T>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueProvider<T>(
      value: create(context),
      child: child,
    );
  }
}

class ValueProvider<T> extends InheritedWidget {
  final T value;

  static T? of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ValueProvider<T>>();
    assert(provider != null);
    return provider!.value;
  }

  ValueProvider({
    required Widget child,
    required this.value,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );
}
