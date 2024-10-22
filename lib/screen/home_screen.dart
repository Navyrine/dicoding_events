import 'package:dicoding_events/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_events/widgets/corousel_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              "Dicoding Events",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            SizedBox(height: 16),
            Text("Upcoming Events"),
            SizedBox(height: 8),
            CorouselEvents(),
            SizedBox(height: 40),
            Text("Finished Events"),
            SizedBox(height: 16,),
            Expanded(child: EventList())
          ],
        ),
      ),
    );
  }
}
