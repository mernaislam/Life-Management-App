import 'package:flutter/material.dart';
import 'package:life_management/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/providers/task_provider.dart';
import 'package:life_management/widgets/tags_drop_down_menu.dart';

class NewTaskScreen extends ConsumerStatefulWidget {
  const NewTaskScreen({super.key});

  @override
  ConsumerState<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends ConsumerState<NewTaskScreen> {
  var _dropDownValue = 'Tags';
  var _currentDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final _enteredText = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _saveTask() {
    bool valid = formKey.currentState!.validate();
    if (!valid) return;
    formKey.currentState!.save();
    if (_dropDownValue == 'Tags') {
      ref.read(taskList.notifier).addTask(
            TaskModel(
              name: _enteredText.text,
              date: _currentDate,
              time: _timeOfDay,
            ),
          );
    } else {
      ref.read(taskList.notifier).addTask(
            TaskModel(
              name: _enteredText.text,
              date: _currentDate,
              time: _timeOfDay,
              tag: _dropDownValue
            ),
          );
    }
    print('ayhaga');
    Navigator.of(context).pop();
  }

  void _datePicker() async {
    var now = DateTime.now();
    var last = DateTime(now.year + 5);
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: now,
      lastDate: last,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context)
                  .colorScheme
                  .background, // header background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;
    setState(() {
      _currentDate = date;
    });
  }

  void showTimingPicker() async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context)
                  .colorScheme
                  .background, // header background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime == null) return;
    setState(() {
      _timeOfDay = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        iconTheme: IconThemeData(
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromRadius(20),
          child: SizedBox(),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(1000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a new task',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\tDate & Time',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 27,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...['Day', 'Month', 'Year', 'Time'].map(
                        (element) => Text(
                          element,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.shadow,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...[
                          _currentDate.day,
                          _currentDate.month,
                          _currentDate.year
                        ].map(
                          (date) => TextButton(
                            onPressed: _datePicker,
                            child: Text(
                              date.toString(),
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: showTimingPicker,
                          child: Text(
                            _timeOfDay.format(context).toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '\tTask Name',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 27,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.shadow,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Task Name',
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.2),
                        ),
                        border: InputBorder.none,
                      ),
                      controller: _enteredText,
                      validator: (String? value) {
                        return (value == null || value.trim().isEmpty)
                            ? 'You must provide a task name'
                            : null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '\tNotes:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 27,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.shadow,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: TextField(
                      autocorrect: false,
                      maxLines: 3,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      decoration: InputDecoration(
                          hintText: 'Write task notes here',
                          fillColor: Colors.amber,
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.2),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '\tAdd a tag',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 27,
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '#',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 27,
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: TagsDropdownMenu(
                            dropDownValue: _dropDownValue,
                            onChanged: (value) {
                              _dropDownValue = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
