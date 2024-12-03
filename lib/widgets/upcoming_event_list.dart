import 'package:dicoding_events/provider/upcoming_event_provider.dart';
import 'package:dicoding_events/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingEventList extends ConsumerWidget {
  const UpcomingEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvent = ref.watch(upcomingEventProvider);

    return upcomingEvent.when(
      data: (upcoming) {
        if (upcoming.isEmpty) {
          return const Center(
            child: Text('No event available'),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          separatorBuilder: (ctx, index) => const SizedBox(height: 1),
          itemCount: upcoming.length,
          itemBuilder: (ctx, index) => EventItem(
              mediaCover: upcoming[index].mediaCover,
              category: upcoming[index].category,
              name: upcoming[index].name),
        );
      },
      error: (error, stack) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
