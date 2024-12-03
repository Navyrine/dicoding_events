import 'package:dicoding_events/provider/finished_event_provider.dart';
import 'package:dicoding_events/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishedEventList extends ConsumerWidget {
  const FinishedEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finishedEvent = ref.watch(finishedEventProvider);

    return finishedEvent.when(
      data: (finished) {
        if (finished.isEmpty) {
          return const Text('No event available');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          separatorBuilder: (ctx, index) => const SizedBox(height: 15),
          itemCount: finished.length,
          itemBuilder: (ctx, index) => EventItem(
              mediaCover: finished[index].mediaCover,
              category: finished[index].category,
              name: finished[index].name),
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
