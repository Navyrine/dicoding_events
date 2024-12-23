import 'package:dicoding_events/models/event.dart';
import 'package:flutter/material.dart';

class HomeEventItem extends StatelessWidget {
  const HomeEventItem(
      {super.key,
      required this.eventData,
      });

  final Event eventData;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4), offset: const Offset(0, 8))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  eventData.mediaCover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventData.category,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        eventData.name,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 40,
              ),
            ],
          ),
        ),
    );
  }
}
