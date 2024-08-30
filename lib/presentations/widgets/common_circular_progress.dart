import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter_supabase/core/constant/color_constant.dart';

class CommonCircularProgress extends StatelessWidget {
  const CommonCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CurvedCircularProgressIndicator(
        animationDuration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        color: red,
        strokeWidth: 8,
      ),
    );
  }
}
