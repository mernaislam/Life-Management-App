import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/providers/task_provider.dart';

class AllTasksScreen extends ConsumerStatefulWidget {
  const AllTasksScreen({super.key});
  @override
  ConsumerState<AllTasksScreen> createState() {
    return _AllTasksScreenState();
  }
}

class _AllTasksScreenState extends ConsumerState<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskList);
    allTasks.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              'Your Tasks',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(150),
            bottomLeft: Radius.circular(150),
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'You have ${allTasks.length} task${allTasks.length == 1? '': 's'} :)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).colorScheme.shadow,
                ),
                width: 390,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...allTasks.map(
                      (task) {
                        return Card(
                          color: task.completed
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  checkColor: Colors.white,
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  value: task.completed,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      task.completed = newValue!;
                                    });
                                  },
                                ),
                                Text(
                                  task.name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                task.tag != null
                                    ? Text(
                                        task.tag!,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      )
                                    : Text(
                                        'no tag',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
