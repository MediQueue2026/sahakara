import 'dart:ui' show ImageFilter;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Whether to draw iOS-style frosted glass. Only on iOS, to match the
/// platform's own look; Android and web keep the solid surfaces.
bool get useGlassEffect =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

/// A frosted-glass panel in the style of iOS: whatever is behind it is
/// blurred, washed with [tint], and edged with a thin light rim and a soft
/// highlight along the top.
class GlassPanel extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;

  /// The colour washed over the blur. Kept partly see-through so the
  /// content behind still shows.
  final Color tint;

  const GlassPanel({
    super.key,
    required this.child,
    required this.tint,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
  });

  @override
  Widget build(BuildContext context) {
    // The shadow sits outside the clip, so it is drawn by its own box.
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  tint.withValues(alpha: 0.72),
                  tint.withValues(alpha: 0.52),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.white.withValues(alpha: 0.28),
                  Colors.white.withValues(alpha: 0),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// [base] with the height of a floating glass bar added to its bottom, so
/// the end of a list can scroll clear of the bar. Adds nothing where no
/// bar overlaps the content.
EdgeInsets clearOfGlassBar(BuildContext context, EdgeInsets base) =>
    base.copyWith(bottom: base.bottom + MediaQuery.paddingOf(context).bottom);
