import 'package:flutter/material.dart';

/// Hər dəfə [visibleExpenses] dəyişəndə (əlavə/sil/filtr) siyahı yenidən
/// qurulur — bu wrapper həmin anda hər sətrin yumşaq görünməsini təmin edir.
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final int index;

  const FadeSlideIn({super.key, required this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    final delay = (index * 30).clamp(0, 240);
    return TweenAnimationBuilder<double>(
      key: ValueKey('fade_$index'),
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
