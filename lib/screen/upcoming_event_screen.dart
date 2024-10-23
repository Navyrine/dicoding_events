import 'package:dicoding_events/widgets/upcoming_event_list.dart';
import 'package:flutter/material.dart';

class UpcomingEventScreen extends StatelessWidget
{
  const UpcomingEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Event", style: TextStyle(fontSize: 28),),
      ),
      body: const UpcomingEventList(),
    );
  }
}