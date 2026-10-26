import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

/// Pushed screens: Android fades forwards, iOS keeps the native slide (and
/// its swipe-back gesture).
const pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

/// Cross-fades between screens that replace each other in place (tabs, the
/// login → loading → home flow) with a slight zoom, Material "fade through"
/// style: the old child fades out before the new one finishes fading in.
///
/// A child that keeps the same type but should still animate needs a
/// distinct [Key]. Respects the system "reduce motion" setting.
class FadeThroughSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final AlignmentGeometry alignment;

  const FadeThroughSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : duration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (current, previous) => Stack(
        alignment: alignment,
        children: [...previous, if (current != null) current],
      ),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: const Interval(0.35, 1),
        ),
        child: ScaleTransition(
          scale: Tween(begin: 0.97, end: 1.0).animate(animation),
          child: _InertWhileLeaving(animation: animation, child: child),
        ),
      ),
      child: child,
    );
  }
}

/// Stops a child that's fading out from taking taps or flying heroes: two
/// tabs with FloatingActionButtons (same default hero tag) would otherwise
/// both be on screen for a moment, and pushing a route then fails.
class _InertWhileLeaving extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _InertWhileLeaving({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final leaving = animation.status == AnimationStatus.reverse ||
            animation.status == AnimationStatus.dismissed;
        return IgnorePointer(
          ignoring: leaving,
          child: HeroMode(enabled: !leaving, child: child!),
        );
      },
      child: child,
    );
  }
}

/// Shows or hides [child] by growing it open (or shrinking it shut) while it
/// fades, so the widgets below slide along instead of jumping. Respects the
/// system "reduce motion" setting.
class AnimatedReveal extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Duration duration;

  const AnimatedReveal({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : duration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        alignment: Alignment.topCenter,
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: visible
          ? KeyedSubtree(key: const ValueKey(true), child: child)
          : const SizedBox(key: ValueKey(false), width: double.infinity),
    );
  }
}
