import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_management/widgets/wave_clipper_second.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  String formatDay(String pattern) {
    return DateFormat(pattern).format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
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
                '\tToday you have x tasks',
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
            ],
          ),
        ),
      ),
    );
  }
}
