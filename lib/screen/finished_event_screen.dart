import 'package:dicoding_events/widgets/finished_event_list.dart';
import 'package:flutter/material.dart';

class FinishedEventScreen extends StatelessWidget {
  const FinishedEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finished Events",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: const FinishedEventList(),
    );
  }
}
