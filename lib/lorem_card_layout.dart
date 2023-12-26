import 'package:flutter/material.dart';

class LoremCardLayout extends StatelessWidget {
  const LoremCardLayout({super.key, required this.title, required this.paragraph, required this.stars});

  final Widget title;
  final Widget paragraph;
  final Widget stars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          title,
                          const Spacer(),
                          stars,
                        ],
                      )),
                  Expanded(
                    child: paragraph,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
