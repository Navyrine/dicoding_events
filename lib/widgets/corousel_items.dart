import 'dart:ui';

import 'package:flutter/material.dart';

class CorouselItems extends StatelessWidget {
  const CorouselItems(
      {super.key, required this.mediaCover, required this.name});

  final String mediaCover;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: Stack(
        children: [
          Image.network(
            mediaCover,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  height: 50,
                  color: Colors.white.withOpacity(0.24),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 21, 38),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
