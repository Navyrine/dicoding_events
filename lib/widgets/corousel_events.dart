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

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("event-api.dicoding.dev", "events", {"active": "1"});

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
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
          _eventDicoding = loadedItem;
        });
      } else {
        _error = "Failed to load data";
      }
    } catch (e) {
      setState(() {
        _error = "Something went wrong: $e";
        print(e);
      });
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
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _eventDicoding.length,
        itemBuilder: (ctx, index) => Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          elevation: 10,
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
          child: Stack(
            children: [
              Image.network(
                _eventDicoding[index].mediaCover,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    _eventDicoding[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
