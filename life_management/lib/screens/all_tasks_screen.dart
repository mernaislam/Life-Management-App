import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/providers/task_provider.dart';
import 'package:life_management/screens/new_task_screen.dart';
import 'package:life_management/screens/task_details_screen.dart';

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
    if (_sortChoice == 'Oldest to Newest') {
      allTasks.sort(
        (a, b) => a.date.compareTo(b.date),
      );
    } else {
      allTasks.sort(
        (a, b) => b.date.compareTo(a.date),
      );
    }
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
                        children: [
                          Text(
                            'Start adding new Tasks!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const NewTaskScreen()));
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
                    if (allTasks.isNotEmpty || _filterChoice != 'All')
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'Sort',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                              ),
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
                                            fontSize: 14),
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
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                              ),
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
                      const Center(
                        child: Text('No Tasks for this tag available'),
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
                          child: Card(
                            color: task.completed
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.tertiary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 30,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    checkColor: Colors.white,
                                    activeColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    value: task.completed,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        task.completed = newValue!;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Flexible(
                                      child: Text(
                                        task.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  task.tag != ''
                                      ? Text(
                                          '#${task.tag}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const Text(''),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (allTasks.isNotEmpty)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const NewTaskScreen()));
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
