import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  const Stars({required this.stars, super.key});

  final int stars;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(
      stars,
      (int index) => const Icon(
        Icons.star,
        color: Colors.pink,
        size: 16,
      ),
    ).toList());
  }
}
