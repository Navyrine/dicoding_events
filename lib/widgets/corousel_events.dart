import 'package:dicoding_events/widgets/corousel_items.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dicoding_events/models/event.dart';
import 'package:http/http.dart' as http;

class CorouselEvents extends StatefulWidget {
  const CorouselEvents({super.key});

  @override
  State<CorouselEvents> createState() => _CorouselEventsState();
}

class _CorouselEventsState extends State<CorouselEvents> {
  List<Event> _eventDicoding = [];
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
      final List<Event> loadedItem = [];
      final List<dynamic> convertDataJson = jsonData["listEvents"];

      for (final item in convertDataJson) {
        loadedItem.add(
          Event(
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
          ),
        );
      }
      setState(() {
        _isLoading = false;
        _eventDicoding = loadedItem;
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
      return const Center(child: CircularProgressIndicator(),);
    }

    if (_error != null) {
      return Center(child: Text(_error!),);
    }


    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      scrollDirection: Axis.horizontal,
      itemCount: _eventDicoding.length >= 5 ? 5 : _eventDicoding.length,
      itemBuilder: (ctx, index) => CorouselItems(
          mediaCover: _eventDicoding[index].mediaCover,
          name: _eventDicoding[index].name),
    );
  }
}
