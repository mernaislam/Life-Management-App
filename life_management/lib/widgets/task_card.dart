import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/models/task.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard(
      {super.key,
      required this.addMargin,
      required this.addPadding,
      required this.addTag,
      required this.task});
  final bool addMargin;
  final bool addPadding;
  final bool addTag;
  final TaskModel task;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final TaskModel currentTask = widget.task;
    return Card(
      color: widget.task.completed
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).colorScheme.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: widget.addMargin
          ? const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            )
          : null,
      child: Padding(
        padding: widget.addPadding
            ? const EdgeInsets.only(
                left: 10,
                right: 30,
                top: 5,
                bottom: 5,
              )
            : const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              checkColor: Colors.white,
              activeColor: Theme.of(context).colorScheme.background,
              value: widget.task.completed,
              onChanged: (bool? newValue) {
                setState(() {
                  widget.task.completed = newValue!;
                });
              },
            ),
            SizedBox(
              width: 150,
              child: Flexible(
                child: Text(
                  currentTask.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (widget.addTag) const Spacer(),
            if (widget.addTag)
              currentTask.tag != ''
                  ? Text(
                      '#${currentTask.tag}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    )
                  : const Text(''),
          ],
        ),
      ),
    );
  }
}
