import 'package:fatracker/animations/container/spinning.dart';
import 'package:flutter/material.dart';

class FadeOutFadeIn extends StatefulWidget {
  const FadeOutFadeIn({super.key});

  @override
  State<FadeOutFadeIn> createState() => _FadeOutFadeInState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _FadeOutFadeInState extends State<FadeOutFadeIn>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinningContainer(
      controller: _controller,
      spinningWidget: context.widget,
    );
  }
}
