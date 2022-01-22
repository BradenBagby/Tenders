import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final double size;
  const PageIndicator(
      {required this.pageCount, required this.currentPage, this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<int>.generate(pageCount, (i) => i)
          .map((i) => Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(i == currentPage ? 100 : 0),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(100),
                        width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
