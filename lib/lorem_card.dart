import 'package:flutter/material.dart';
import 'package:inifinite_loading/lorem_card_layout.dart';
import 'package:inifinite_loading/stars.dart';

import 'main.dart';

class LoremCard extends StatelessWidget {
  const LoremCard({super.key, required this.lorem});

  final Lorem lorem;
  @override
  Widget build(BuildContext context) {
    return LoremCardLayout(
        title: Text(
          lorem.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        paragraph: Text(
          lorem.paragraph,
          maxLines: 3,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        stars: Stars(stars: lorem.stars));
  }
}
