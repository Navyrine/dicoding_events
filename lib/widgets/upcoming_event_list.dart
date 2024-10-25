import 'dart:convert';

import 'package:dicoding_events/models/event.dart';
import 'package:dicoding_events/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpcomingEventList extends StatefulWidget {
  const UpcomingEventList({super.key});

  @override
  State<UpcomingEventList> createState() {
    return _EventListState();
  }
}

class _EventListState extends State<UpcomingEventList> {
  List<Event> _upcomingEventDicoding = [];
  String? _error;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("event-api.dicoding.dev", "events", {"active": "1"});

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _isLoading = false;
          _error = "Failed to fetch data";
        });
      }

      if (response.body == "null") {
        setState(() {
          _isLoading = false;
        });
        return;
      }

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
        _isLoading = false;
        _upcomingEventDicoding = laoddedItem;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Something went wrong: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(_error!),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      separatorBuilder: (ctx, index) => const SizedBox(height: 1),
      itemCount: _upcomingEventDicoding.length,
      itemBuilder: (ctx, index) => EventItem(
          mediaCover: _upcomingEventDicoding[index].mediaCover,
          category: _upcomingEventDicoding[index].category,
          name: _upcomingEventDicoding[index].name),
    );
  }
}
