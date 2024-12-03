import 'package:dicoding_events/provider/finished_event_provider.dart';
import 'package:dicoding_events/widgets/home_event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEventList extends ConsumerWidget {
  const HomeEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finishedEvent = ref.watch(finishedEventProvider);

    return finishedEvent.when(
      data: (finished) {
        if (finished.isEmpty) {
          return const Center(
            child: Text('No finished event available'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          separatorBuilder: (ctx, index) => const SizedBox(height: 15),
          itemCount: finished.length >= 5 ? 5 : finished.length,
          itemBuilder: (ctx, index) => HomeEventItem(
            eventData: finished[index],
          ),
        );
      },
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
