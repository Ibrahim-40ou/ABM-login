import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color color;

  const CustomLoadingIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}
