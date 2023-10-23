import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/models/task.dart';
import 'package:life_management/providers/task_provider.dart';
import 'package:life_management/screens/new_task_screen.dart';
import 'package:life_management/screens/task_details_screen.dart';
import 'package:life_management/widgets/task_card.dart';

class AllTasksScreen extends ConsumerStatefulWidget {
  const AllTasksScreen({super.key});
  @override
  ConsumerState<AllTasksScreen> createState() {
    return _AllTasksScreenState();
  }
}

class _AllTasksScreenState extends ConsumerState<AllTasksScreen> {
  var _sortChoice = 'Oldest to Newest';
  var _filterChoice = 'All';
  @override
  Widget build(BuildContext context) {
    var allTasks = ref.watch(taskList);
    _sortChoice == 'Oldest to Newest'
        ? allTasks.sort(
            (a, b) => a.date.compareTo(b.date),
          )
        : allTasks.sort(
            (a, b) => b.date.compareTo(a.date),
          );
    if (_filterChoice != 'All') {
      var newTask = allTasks.where((task) => task.tag == _filterChoice);
      allTasks = newTask.toList();
    }

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
              const SizedBox(
                height: 20,
              ),
              Text(
                'You have ${allTasks.length} task${allTasks.length == 1 ? '' : 's'} : )',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).colorScheme.shadow,
                ),
                constraints:
                    const BoxConstraints(minHeight: 600, minWidth: 370),
                child: Column(
                  children: [
                    if (allTasks.isEmpty && _filterChoice == 'All')
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start adding new Tasks!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    if (allTasks.isNotEmpty || _filterChoice != 'All')
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Sort',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            DropdownButton(
                              value: _sortChoice,
                              dropdownColor: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(1),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              items: ['Oldest to Newest', 'Newest to Oldest']
                                  .map(
                                    (option) => DropdownMenuItem(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _sortChoice = value!;
                                });
                              },
                            ),
                            const Spacer(),
                            Text(
                              'Filter',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            DropdownButton(
                              value: _filterChoice,
                              dropdownColor: Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(1),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              items: [
                                'All',
                                'Important',
                                'Work',
                                'Learn',
                                'Fun',
                                'Personal'
                              ]
                                  .map(
                                    (option) => DropdownMenuItem(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _filterChoice = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    if (allTasks.isEmpty && _filterChoice != 'All')
                      Text(
                        'No Tasks for this tag available',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ...allTasks.map(
                      (task) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => TaskDetailsScreen(task: task),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: Key(task.date.toString()),
                            onDismissed: (direction) {
                              TaskModel currentTask = task;
                              ref
                                  .watch(taskList.notifier)
                                  .deleteTask(task);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('${task.name} is deleted'),
                                action: SnackBarAction(
                                  label: 'undo',
                                  onPressed: () {
                                    ref
                                        .watch(taskList.notifier)
                                        .addTask(currentTask);
                                  },
                                ),
                              ));
                            },
                            background: Container(
                              margin: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 10,
                                    ),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.red,
                              ),
                            ),
                            child: TaskCard(
                              addMargin: true,
                              addPadding: true,
                              addTag: true,
                              task: task,
                            ),
                          ),
                        );
                      },
                    ),
                    // show add task in all cases
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const NewTaskScreen(choice: "task",),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Text('Add Task'),
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
