import 'package:flutter/material.dart';
import 'package:inifinite_loading/infinite_list/loader_placeholder.dart';
import 'package:inifinite_loading/lorem_card_layout.dart';

class LoadingLoremCard extends StatelessWidget {
  const LoadingLoremCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoremCardLayout(
      title: LoaderPlaceholder(width: 200, child: Text('.....')),
      paragraph: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoaderPlaceholder(width: double.infinity, child: Text('.....')),
          SizedBox(height: 8),
          LoaderPlaceholder(width: double.infinity, child: Text('.....')),
          SizedBox(height: 8),
          LoaderPlaceholder(child: Text('.....')),
        ],
      ),
      stars: LoaderPlaceholder(width: 100, child: Text('.....')),
    );
  }
}
