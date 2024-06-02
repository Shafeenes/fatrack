// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BouncingExitAnimation extends StatefulWidget {
//   ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
//       animationChild;
//   BouncingExitAnimation({super.key, required this.animationChild});

//   @override
//   State<BouncingExitAnimation> createState() => _BouncingExitAnimationState();
// }

// class _BouncingExitAnimationState extends State<BouncingExitAnimation>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(seconds: 2),
//     vsync: this,
//   )..repeat(reverse: true);
//   late final Animation<Offset> _offsetAnimation = Tween<Offset>(
//     begin: Offset.zero,
//     end: const Offset(1.5, 0.0),
//   ).animate(CurvedAnimation(
//     parent: _controller,
//     curve: Curves.elasticIn,
//   ));

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _offsetAnimation,
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Materia,
//       ),
//     );
//   }
// }
