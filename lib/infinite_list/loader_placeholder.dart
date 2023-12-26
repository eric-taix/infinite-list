import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderPlaceholder extends StatelessWidget {
  const LoaderPlaceholder({
    Key? key,
    this.width,
    this.child,
  }) : super(key: key);

  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardTheme.color ?? const Color(0xFFF7F1FB),
      highlightColor: Colors.purple,
      child: Container(
        width: width,
        height: 12.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.purple,
        ),
        child: child,
      ),
    );
  }
}
