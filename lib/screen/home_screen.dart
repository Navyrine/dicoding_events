
import 'package:flutter/material.dart';
import 'package:dicoding_events/widgets/corousel_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [Expanded(child: CorouselEvents())],
              ),
            )
          ],
        ),
      ),
    );
  }
}
