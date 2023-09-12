import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_management/models/task.dart';
import 'package:life_management/widgets/wave_clipper.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    Map<String, String> mp = {
      'Assign Date: ': DateFormat('EEE, MMM d, y').format(task.date).toString(),
      'Task Tag: ': task.tag,
      'Task Status: ': task.completed ? 'Done' : 'In Progress',
      'Task Notes: ': task.notes,
    };
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
        iconTheme: IconThemeData(
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        scrolledUnderElevation: 0.0,
        toolbarHeight: 70,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipPath(
          clipper: WaveClipper(),
          child: Container(
            alignment: Alignment.centerRight,
            color: Theme.of(context).colorScheme.primary,
            height: 150,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                task.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  for (var k in mp.entries)
                    if (k.value != '')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              k.key,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            if (k.key != 'Task Notes: ')
                              Text(
                                k.value,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 8, top: 8),
                    child: Text(
                      task.notes,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
