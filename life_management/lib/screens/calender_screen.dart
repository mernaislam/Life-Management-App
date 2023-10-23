import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:life_management/models/event.dart';
import 'package:life_management/providers/event_provider.dart';
import 'package:life_management/providers/task_provider.dart';
import 'package:life_management/screens/new_task_screen.dart';
import 'package:life_management/widgets/wave_clipper_second.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends ConsumerStatefulWidget {
  const CalenderScreen({super.key});
  @override
  ConsumerState<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalenderScreen> {
  String formatDay(String pattern) {
    return DateFormat(pattern).format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    var list = ref.watch(eventList);
    var listTasks = ref.watch(taskList);
    final todayTasksCnt = listTasks.where((task) => task.date.day == DateTime.now().day,).length;
    final todayEvents = list.where((event) => event.date.day == DateTime.now().day,);
    final eventCnt = todayEvents.length;
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
        scrolledUnderElevation: 0.0,
        toolbarHeight: 80,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        iconTheme: IconThemeData(
          size: 28,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipPath(
          clipper: WaveClipperSecond(),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 200,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calendar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '\tToday you have $todayTasksCnt task${todayTasksCnt == 1 ? '' : 's'}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 19,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  '${formatDay('EEEE')} ${formatDay('MMMM')} ${formatDay('d')}th. ${DateTime.now().year}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.shadow,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/butterfly.png'),
                      ),
                    ),
                    tablePadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    defaultTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    outsideTextStyle: TextStyle(
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(0),
                    ),
                    weekendTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    // setState(() {
                    //   focusedDay = selectedDay;
                    // });
                  },
                  selectedDayPredicate: (day) {
                    return false;
                  },
                  daysOfWeekHeight: 50,
                  rowHeight: 40,
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    weekendStyle: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    dowTextFormatter: (date, locale) {
                      return DateFormat('E').format(date).toString()[0];
                    },
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '\tYou have $eventCnt event${eventCnt == 1 ? '' : 's'} today',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              const NewTaskScreen(choice: "event"),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
              for (EventModel event in todayEvents)
                Card(
                  color: Theme.of(context).colorScheme.shadow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 30,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Flexible(
                            child: Text(
                              event.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        if(event.tag != '')
                          Text(
                            '\t. #${event.tag}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 13,
                            ),
                          )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
