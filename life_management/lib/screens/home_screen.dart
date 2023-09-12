import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:life_management/models/task.dart';
import 'package:life_management/providers/task_provider.dart';
import 'package:life_management/screens/all_tasks_screen.dart';
import 'package:life_management/screens/new_task_screen.dart';
import 'package:life_management/widgets/drawer_content.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskList);
    List<TaskModel> renderedTasks = allTasks;
    if (allTasks.length > 4) {
      renderedTasks = allTasks.sublist(0, 4);
    }
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: const DrawerContent(),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'hello Jane',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'ready to take on the day?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
          size: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            margin: const EdgeInsets.all(15),
            height: 320,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Theme.of(context).colorScheme.shadow,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      label: Text(
                        'edit dashboard',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            DateFormat('EEEE')
                                .format(DateTime.now())
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 17,
                                letterSpacing: 1),
                          ),
                          Text(
                            DateFormat('d').format(DateTime.now()).toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM')
                                .format(DateTime.now())
                                .toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        if (allTasks.isEmpty)
                          Text(
                            '\t\tYou have no tasks\nStart adding new ones',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        if (renderedTasks.isNotEmpty)
                          ...renderedTasks.map(
                            (task) {
                              return SizedBox(
                                height: 45,
                                child: Card(
                                  color: task.completed
                                      ? Theme.of(context)
                                          .colorScheme
                                          .background
                                      : Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            maxLines: 1,
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
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 9,
                          ),
                          minimumSize: const Size(0, 0)),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_circle_up,
                        size: 15,
                      ),
                      label:
                          const Text('share', style: TextStyle(fontSize: 13)),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 9,
                          ),
                          minimumSize: const Size(0, 0)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const NewTaskScreen(),
                            maintainState: false,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 15,
                      ),
                      label: const Text(
                        'add',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 9,
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const AllTasksScreen(),
                            maintainState: false,
                          ),
                        );
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.arrow_downward_outlined,
                        size: 15,
                      ),
                      label: const Text('all tasks'),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            margin: const EdgeInsets.all(15),
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Theme.of(context).colorScheme.shadow,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 9,
                          ),
                          minimumSize: const Size(0, 0)),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_circle_up,
                        size: 15,
                      ),
                      label:
                          const Text('share', style: TextStyle(fontSize: 13)),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          'Grocery List',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'X items remaining',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 9,
                        ),
                        minimumSize: const Size(0, 0),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 15,
                      ),
                      label: const Text(
                        'add',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text('List to be added'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                margin: const EdgeInsets.only(
                  left: 15,
                  top: 15,
                ),
                height: 230,
                width: 185,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).colorScheme.shadow,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        'assets/images/cooking.jpg',
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Quick & easy receipes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 9,
                        ),
                        minimumSize: const Size(0, 0),
                      ),
                      child: const Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 5,
                ),
                margin: const EdgeInsets.only(
                  right: 15,
                  top: 15,
                ),
                height: 230,
                width: 185,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).colorScheme.shadow,
                ),
                child: Column(
                  children: [
                    Text(
                      'Calender',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'X events today',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text('List to be added'),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
