import 'dart:ui';

import 'package:flutter/material.dart';

class CorouselItems extends StatelessWidget {
  const CorouselItems(
      {super.key, required this.mediaCover, required this.name});

  final String mediaCover;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Expanded(
              child: Image.network(
                mediaCover,
                height: 200,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 21, 38)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
