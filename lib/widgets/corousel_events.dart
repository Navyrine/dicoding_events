import 'package:dicoding_events/provider/upcoming_event_provider.dart';
import 'package:dicoding_events/widgets/corousel_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorouselEvents extends ConsumerWidget {
  const CorouselEvents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingProvider = ref.watch(upcomingEventProvider);

    return upcomingProvider.when(
      data: (upcoming) {
        if (upcoming.isEmpty) {
          return const Center(
            child: Text('No upcoming event available'),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: upcoming.length >= 5 ? 5 : upcoming.length,
          itemBuilder: (ctx, index) => CorouselItems(
              mediaCover: upcoming[index].mediaCover,
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
