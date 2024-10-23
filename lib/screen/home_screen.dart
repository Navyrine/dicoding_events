import 'package:dicoding_events/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_events/widgets/corousel_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dicoding Events",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upcoming Events"),
            SizedBox(height: 8),
            SizedBox(height: 197, child: CorouselEvents()),
            SizedBox(height: 20),
            Text("Finished Events"),
            SizedBox(height: 8),
            Expanded(child: EventList())
          ],
        ),
      ),
    );
  }
}
