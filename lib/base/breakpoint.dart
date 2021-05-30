import 'media_query_data.dart';

class Breakpoint {
  final int minSize;
  final MediaSize size;

  const Breakpoint(this.size, this.minSize);

  static Breakpoint defaultBreakpoint(MediaSize size) {
    switch (size) {
      case MediaSize.xsmall:
        return Breakpoint(size, 0);
      case MediaSize.small:
        return Breakpoint(size, 600);
      case MediaSize.large:
        return Breakpoint(size, 1440);
      case MediaSize.xlarge:
        return Breakpoint(size, 1920);
      case MediaSize.medium:
        return const Breakpoint(MediaSize.medium, 1024);
    }
  }
}
