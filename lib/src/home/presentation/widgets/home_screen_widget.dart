import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/src/home/presentation/providers/tasks_provider.dart';

class HomeScreenWidget extends ConsumerWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Tasks', style: context.textTheme.bodyLarge),
        const SizedBox(height: 24),
        tasksState.when(
          data: (tasks) => Expanded(
            child: tasks.isEmpty
                ? Center(child: Text('No Tasks Found', style: context.textTheme.bodyLarge))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks.elementAt(index).name),
                        subtitle: Text(tasks.elementAt(index).date.toString()),
                      );
                    },
                  ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ],
    );
  }
}
