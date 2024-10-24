import 'dart:convert';

import 'package:dicoding_events/models/event.dart';
import 'package:dicoding_events/widgets/home_event_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() {
    return _EventListState();
  }
}

class _EventListState extends State<EventList> {
  List<Event> _eventDicoding = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("event-api.dicoding.dev", "events", {"active": "0"});

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<Event> laoddedItem = [];
        final List<dynamic> convertDataJson = jsonData["listEvents"];

        for (final item in convertDataJson) {
          laoddedItem.add(Event(
            id: item["id"],
            name: item["name"],
            summary: item["summary"],
            description: item["description"],
            imageLogo: item["imageLogo"],
            mediaCover: item["mediaCover"],
            category: item["category"],
            ownerName: item["ownerName"],
            cityName: item["cityName"],
            quota: item["quota"],
            registrants: item["registrants"],
            beginTime: item["beginTime"],
            endTime: item["endTime"],
            link: item["link"],
          ));
        }
        setState(() {
          _eventDicoding = laoddedItem;
        });
      } else {
        _error = "Failed to load data";
      }
    } catch (e) {
      _error = "Something went wrong: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(child: Text(_error!));
    }

    if (_eventDicoding.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      separatorBuilder: (ctx, index) => const SizedBox(height: 15),
      itemCount: _eventDicoding.length >= 5 ? 5 : _eventDicoding.length,
      itemBuilder: (ctx, index) => EventItem(
          mediaCover: _eventDicoding[index].mediaCover,
          category: _eventDicoding[index].category,
          name: _eventDicoding[index].name),
    );
  }
}
