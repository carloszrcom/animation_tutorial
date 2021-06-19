import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatefulWidget {
  AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this, // The SingleTickerProviderStateMixin
      duration: Duration(seconds: 5),
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(curvedAnimation) // animController
      // ..addListener(() { /// El setState es ahora llamado implicitamente por
      //   setState(() {}); /// CzrImage.
      // })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });

    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CzrImage(
        animation: animation,
      ),
    );
  }
}

// class RotatingTransition extends StatelessWidget {
//   const RotatingTransition({
//     Key? key,
//     required this.angle,
//     required this.child,
//   }) : super(key: key);

//   final Widget child;
//   final Animation<double> angle;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: angle,
//       child: child,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: angle.value,
//           child: child,
//         );
//       },
//     );
//   }
// }

/// AnimatedWidget hereda de StatefulWidget
class CzrImage extends AnimatedWidget {
  const CzrImage({
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final animation = this.listenable as Animation<double>;

    return Transform.rotate(
      angle: animation.value,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(90),
        child: Image.asset('assets/images/czr.png'),
      ),
    );
  }
}
