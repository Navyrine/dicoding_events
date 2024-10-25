import 'dart:convert';

import 'package:dicoding_events/models/event.dart';
import 'package:dicoding_events/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FinishedEventList extends StatefulWidget {
  const FinishedEventList({super.key});

  @override
  State<FinishedEventList> createState() {
    return _EventListState();
  }
}

class _EventListState extends State<FinishedEventList> {
  List<Event> _finishedEventDicoding = [];
  String? _error;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("event-api.dicoding.dev", "events", {"active": "0"});

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
        _finishedEventDicoding = laoddedItem;
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
      separatorBuilder: (ctx, index) => const SizedBox(height: 15),
      itemCount: _finishedEventDicoding.length,
      itemBuilder: (ctx, index) => EventItem(
          mediaCover: _finishedEventDicoding[index].mediaCover,
          category: _finishedEventDicoding[index].category,
          name: _finishedEventDicoding[index].name),
    );
  }
}
