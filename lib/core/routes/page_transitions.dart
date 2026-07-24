// core/routes/page_transitions.dart
import 'package:flutter/material.dart';

Widget buildSmoothTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
  final slide = Tween<Offset>(
    begin: const Offset(0, 0.06),
    end: Offset.zero,
  ).animate(curved);

  return FadeTransition(
    opacity: curved,
    child: SlideTransition(position: slide, child: child),
  );
}

const Duration smoothTransitionDuration = Duration(milliseconds: 320);
const Duration smoothReverseTransitionDuration = Duration(milliseconds: 260);
