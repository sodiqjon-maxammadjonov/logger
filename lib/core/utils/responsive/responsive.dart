import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;
}

class ResponsivePadding {
  static const EdgeInsets mobile = EdgeInsets.all(16);
  static const EdgeInsets tablet = EdgeInsets.all(24);
  static const EdgeInsets desktop = EdgeInsets.all(32);

  static EdgeInsets responsive(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return mobile;
    if (ResponsiveUtils.isTablet(context)) return tablet;
    return desktop;
  }
}

class ResponsiveSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static Widget get vXS => const SizedBox(height: xs);
  static Widget get vSM => const SizedBox(height: sm);
  static Widget get vMD => const SizedBox(height: md);
  static Widget get vLG => const SizedBox(height: lg);
  static Widget get vXL => const SizedBox(height: xl);

  static Widget get hXS => const SizedBox(width: xs);
  static Widget get hSM => const SizedBox(width: sm);
  static Widget get hMD => const SizedBox(width: md);
  static Widget get hLG => const SizedBox(width: lg);
  static Widget get hXL => const SizedBox(width: xl);
}

class OptimizedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? width;
  final double? height;

  const OptimizedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: color != null
          ? BoxDecoration(color: color)
          : null,
      child: child,
    );
  }
}