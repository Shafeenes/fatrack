import 'package:flutter/material.dart';

class SpinningContainer extends AnimatedWidget {
  SpinningContainer({
    super.key,
    required AnimationController controller,
    required this.spinningWidget,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;
  Widget spinningWidget;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2.0 * (22 / 7),
      child: spinningWidget,
    );
  }
}
