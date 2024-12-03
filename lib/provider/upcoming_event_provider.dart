import 'dart:convert';

import 'package:dicoding_events/models/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UpcomingEventNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  UpcomingEventNotifier() : super(const AsyncValue.loading()) {
    loadUpcomingEvent();
  }

  Future<void> loadUpcomingEvent() async {
    final url = Uri.parse('https://event-api.dicoding.dev/events?active=1');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        state = AsyncValue.error(
            'Failed to fetch upcoming events data', StackTrace.current);
        return;
      }
      if (response.body == 'null') {
        state = const AsyncValue.data([]);
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<dynamic> eventData = listData['listEvents'];
      final List<Event> loaddedItems = eventData.map((item) {
        return Event(
          id: item['id'],
          name: item['name'],
          summary: item['summary'],
          description: item['description'],
          imageLogo: item['imageLogo'],
          mediaCover: item['mediaCover'],
          category: item['category'],
          ownerName: item['ownerName'],
          cityName: item['cityName'],
          quota: item['quota'],
          registrants: item['registrants'],
          beginTime: item['beginTime'],
          endTime: item['endTime'],
          link: item['link'],
        );
      }).toList();

      state = AsyncValue.data(loaddedItems);
    } catch (e) {
      state = AsyncValue.error('Something went wrong: $e', StackTrace.current);
    }
  }
}

final upcomingEventProvider =
    StateNotifierProvider<UpcomingEventNotifier, AsyncValue<List<Event>>>(
  (ref) => UpcomingEventNotifier(),
);
