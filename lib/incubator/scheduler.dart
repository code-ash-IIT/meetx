import 'package:flutter/material.dart';
import 'package:meetx/incubator/calendar.dart';
import '../homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Schedular extends StatefulWidget{
  @override
  _SchedularState createState() => _SchedularState();
}

class _SchedularState extends State<Schedular> {

  // Duration _duration = const Duration(hours: 0, minutes: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Scheduling page',
                style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent.withOpacity(0.6),
                  fontSize: 40,
                  // fontStyle: FontStyle.italic
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SfCalendar(
                        
                        view: CalendarView.week,
                        onTap: (CalendarTapDetails details) {
                      dynamic appointment = details.appointments;
                      DateTime date = details.date!;
                      CalendarElement element = details.targetElement;
                    },
                        dataSource: MeetingDataSource(_getDataSource()),

                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[

                    Expanded(child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)))
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventCalendar()));
                        print("Meeting scheduled..");
                      },
                      child: const Text('Schedule'),
                    )),

                  ],
                ),
              ),

            ],
          )

      ),

    );
  }
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}