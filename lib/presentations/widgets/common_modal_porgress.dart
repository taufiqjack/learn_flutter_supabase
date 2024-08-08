import 'package:flutter/material.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';

class ModalProgress extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  const ModalProgress({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.5,
    this.color = Colors.grey,
    this.progressIndicator = const CurvedCircularProgressIndicator(
      animationDuration: Duration(seconds: 2),
      backgroundColor: Colors.white,
      color: red,
      strokeWidth: 8,
    ),
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Center(child: progressIndicator);
    } else {
      layOutProgressIndicator = Positioned(
        left: offset?.dx,
        top: offset?.dy,
        child: progressIndicator,
      );
    }

    return Stack(
      children: [
        child,
        Opacity(
          opacity: opacity,
          child: ModalBarrier(dismissible: dismissible, color: color),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
