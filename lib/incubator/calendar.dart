library event_calendar;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import '../homepage.dart';
import 'scheduler.dart';
import 'dart:math';
import 'package:intl/intl.dart' as intl;
import "package:googleapis_auth/auth_io.dart";
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'CalenderClient.dart';
import 'homeadmin.dart';

part 'color-picker.dart';

part 'timezone-picker.dart';

part 'appointment_editor.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

late String _prim_email, mentor_mail, startup_mail;

class EventCalendar extends StatefulWidget {
  final String mentorMail, startupMail, mail;
  const EventCalendar({Key? key, required this.mentorMail, required this.startupMail, required this.mail}) : super(key: key);

  @override
  EventCalendarState createState() => EventCalendarState(mentorMail: this.mentorMail, startupMail: this.startupMail, mail: this.mail);
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';

class EventCalendarState extends State<EventCalendar> {
  final String mentorMail, startupMail, mail;
  EventCalendarState({Key? key, required this.mentorMail, required this.startupMail, required this.mail});

  CalendarView _calendarView = CalendarView.week;
  late List<String> eventNameCollection;
  late List<Meeting> appointments;

  final databaseReference = FirebaseFirestore.instance;
  @override
  void initState() {
    _calendarView = CalendarView.week;
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    _prim_email = this.mail;
    mentor_mail = this.mentorMail;
    startup_mail = this.startupMail;

    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });

    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference
        .collection("CalendarAppointmentCollection").doc(this.startupMail)
        .get();

    final Random random = new Random();
    dynamic em,fr,tt,bg,stz,endz,desc,iad,en;
    Map<String,dynamic>? data = snapShotsValue.data();
    // print(data!['Description']);
    List<Meeting> list=<Meeting>[];
    int sz = data!.length;
    int i=0;
    while(i<sz){
      list.add(
          Meeting(
            email: data.values.elementAt(i)['Email'],///////////////////////////
            from: data.values.elementAt(i)['From'].toDate(),
            to: data.values.elementAt(i)['To'].toDate(),
            background: _colorCollection[3], //_colorCollection[_selectedColorIndex],
            startTimeZone: data.values.elementAt(i)['StartTimeZone'],
            endTimeZone: data.values.elementAt(i)['EndTimeZone'],
            description: data.values.elementAt(i)['Description'],
            isAllDay: data.values.elementAt(i)['isAllDay'],
            eventName: data.values.elementAt(i)['Event Name'],
          )
      );
      i++;
    }

    var snapShotsValue2 = await databaseReference
        .collection("CalendarAppointmentCollection").doc(this.mentorMail)
        .get();

    final Random random2 = new Random();
    // dynamic em,fr,tt,bg,stz,endz,desc,iad,en;
    Map<String,dynamic>? data2 = snapShotsValue2.data();
    // print(data!['Description']);
    // List<Meeting> list2=<Meeting>[];
    int sz2 = data2!.length;
    int i2=0;
    while(i2<sz2){
      list.add(
          Meeting(
            email: data2.values.elementAt(i2)['Email'],///////////////////////////
            from: data2.values.elementAt(i2)['From'].toDate(),
            to: data2.values.elementAt(i2)['To'].toDate(),
            background: _colorCollection[2], //_colorCollection[_selectedColorIndex],
            startTimeZone: data2.values.elementAt(i2)['StartTimeZone'],
            endTimeZone: data2.values.elementAt(i2)['EndTimeZone'],
            description: data2.values.elementAt(i2)['Description'],
            isAllDay: data2.values.elementAt(i2)['isAllDay'],
            eventName: data2.values.elementAt(i2)['Event Name'],
          )
      );
      i2++;
    }
    setState(() {
      _events = DataSource(list);
    });
  }

  void _signOut() async{
    _auth.signOut();
    print("Signed out successfully!");
    Get.offAll(()=>Choices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              color: Color.fromRGBO(244, 244, 242, 1),
              child: Column(
                children: [
                  SizedBox(height: 600 ,child: getEventCalendar(_calendarView, _events, onCalendarTapped)),
                  Align(
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      minWidth: 500.0,
                      // height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(
                                244, 244, 244, 1.0)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                                1, 42, 76, 1.0)),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 30.0, horizontal: 150.0)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),



                        onPressed: () {
                          _signOut();
                        },
                        child: const Text('Log out',
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  SfCalendar getEventCalendar(
      CalendarView _calendarView,
      CalendarDataSource _calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
        view: _calendarView,
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }

  void onCalendarViewChange(String value) {
    if (value == 'Day') {
      _calendarView = CalendarView.day;
    } else if (value == 'Week') {
      _calendarView = CalendarView.week;
    } else if (value == 'Work week') {
      _calendarView = CalendarView.workWeek;
    } else if (value == 'Month') {
      _calendarView = CalendarView.month;
    } else if (value == 'Timeline day') {
      _calendarView = CalendarView.timelineDay;
    } else if (value == 'Timeline week') {
      _calendarView = CalendarView.timelineWeek;
    } else if (value == 'Timeline work week') {
      _calendarView = CalendarView.timelineWorkWeek;
    }

    setState(() {});
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      if (_calendarView == CalendarView.month) {
        _calendarView = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _isAllDay = meetingDetails.isAllDay;
          _prim_email = meetingDetails.email;
          _selectedColorIndex =
              _colorCollection.indexOf(meetingDetails.background);
          _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
          _subject = meetingDetails.eventName == '(No title)'
              ? ''
              : meetingDetails.eventName;
          _notes = meetingDetails.description;
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime =
            TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),
        );
      }
    });
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  List<Meeting> getMeetingDetails() {
    List<Meeting> meetingCollection = <Meeting>[];
    // eventNameCollection = <String>[];
    // eventNameCollection.add('Startup Not available');
    // eventNameCollection.add('Mentor Not available');
    // eventNameCollection.add('Project Plan');
    // eventNameCollection.add('Consulting');
    // eventNameCollection.add('Support');
    // eventNameCollection.add('Development Meeting');
    // eventNameCollection.add('Scrum');
    // eventNameCollection.add('Project Completion');
    // eventNameCollection.add('Release updates');
    // eventNameCollection.add('Performance Check');
    //
    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    //
    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    _colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');
    //
    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');
    _timeZoneCollection.add('AUS Eastern Standard Time');
    _timeZoneCollection.add('Afghanistan Standard Time');
    _timeZoneCollection.add('Alaskan Standard Time');
    _timeZoneCollection.add('Arab Standard Time');
    _timeZoneCollection.add('Arabian Standard Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Argentina Standard Time');
    _timeZoneCollection.add('Atlantic Standard Time');
    _timeZoneCollection.add('Azerbaijan Standard Time');
    _timeZoneCollection.add('Azores Standard Time');
    _timeZoneCollection.add('Bahia Standard Time');
    _timeZoneCollection.add('Bangladesh Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Cape Verde Standard Time');
    _timeZoneCollection.add('Caucasus Standard Time');
    _timeZoneCollection.add('Cen. Australia Standard Time');
    _timeZoneCollection.add('Central America Standard Time');
    _timeZoneCollection.add('Central Asia Standard Time');
    _timeZoneCollection.add('Central Brazilian Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Central Pacific Standard Time');
    _timeZoneCollection.add('Central Standard Time');
    _timeZoneCollection.add('China Standard Time');
    _timeZoneCollection.add('Dateline Standard Time');
    _timeZoneCollection.add('E. Africa Standard Time');
    _timeZoneCollection.add('E. Australia Standard Time');
    _timeZoneCollection.add('E. South America Standard Time');
    _timeZoneCollection.add('Eastern Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('FLE Standard Time');
    _timeZoneCollection.add('Fiji Standard Time');
    _timeZoneCollection.add('GMT Standard Time');
    _timeZoneCollection.add('GTB Standard Time');
    _timeZoneCollection.add('Georgian Standard Time');
    _timeZoneCollection.add('Greenland Standard Time');
    _timeZoneCollection.add('Greenwich Standard Time');
    _timeZoneCollection.add('Hawaiian Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Iran Standard Time');
    _timeZoneCollection.add('Israel Standard Time');
    _timeZoneCollection.add('Jordan Standard Time');
    _timeZoneCollection.add('Kaliningrad Standard Time');
    _timeZoneCollection.add('Korea Standard Time');
    _timeZoneCollection.add('Libya Standard Time');
    _timeZoneCollection.add('Line Islands Standard Time');
    _timeZoneCollection.add('Magadan Standard Time');
    _timeZoneCollection.add('Mauritius Standard Time');
    _timeZoneCollection.add('Middle East Standard Time');
    _timeZoneCollection.add('Montevideo Standard Time');
    _timeZoneCollection.add('Morocco Standard Time');
    _timeZoneCollection.add('Mountain Standard Time');
    _timeZoneCollection.add('Mountain Standard Time (Mexico)');
    _timeZoneCollection.add('Myanmar Standard Time');
    _timeZoneCollection.add('N. Central Asia Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Nepal Standard Time');
    _timeZoneCollection.add('New Zealand Standard Time');
    _timeZoneCollection.add('Newfoundland Standard Time');
    _timeZoneCollection.add('North Asia East Standard Time');
    _timeZoneCollection.add('North Asia Standard Time');
    _timeZoneCollection.add('Pacific SA Standard Time');
    _timeZoneCollection.add('Pacific Standard Time');
    _timeZoneCollection.add('Pacific Standard Time (Mexico)');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('Paraguay Standard Time');
    _timeZoneCollection.add('Romance Standard Time');
    _timeZoneCollection.add('Russia Time Zone 10');
    _timeZoneCollection.add('Russia Time Zone 11');
    _timeZoneCollection.add('Russia Time Zone 3');
    _timeZoneCollection.add('Russian Standard Time');
    _timeZoneCollection.add('SA Eastern Standard Time');
    _timeZoneCollection.add('SA Pacific Standard Time');
    _timeZoneCollection.add('SA Western Standard Time');
    _timeZoneCollection.add('SE Asia Standard Time');
    _timeZoneCollection.add('Samoa Standard Time');
    _timeZoneCollection.add('Singapore Standard Time');
    _timeZoneCollection.add('South Africa Standard Time');
    _timeZoneCollection.add('Sri Lanka Standard Time');
    _timeZoneCollection.add('Syria Standard Time');
    _timeZoneCollection.add('Taipei Standard Time');
    _timeZoneCollection.add('Tasmania Standard Time');
    _timeZoneCollection.add('Tokyo Standard Time');
    _timeZoneCollection.add('Tonga Standard Time');
    _timeZoneCollection.add('Turkey Standard Time');
    _timeZoneCollection.add('US Eastern Standard Time');
    _timeZoneCollection.add('US Mountain Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('UTC+12');
    _timeZoneCollection.add('UTC-02');
    _timeZoneCollection.add('UTC-11');
    _timeZoneCollection.add('Ulaanbaatar Standard Time');
    _timeZoneCollection.add('Venezuela Standard Time');
    _timeZoneCollection.add('Vladivostok Standard Time');
    _timeZoneCollection.add('W. Australia Standard Time');
    _timeZoneCollection.add('W. Central Africa Standard Time');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');
    _timeZoneCollection.add('West Pacific Standard Time');
    _timeZoneCollection.add('Yakutsk Standard Time');
    //
    // CalendarClient calendarClient2 = CalendarClient();
    // meetingCollection = calendarClient2.getEvents(_colorCollection);
    // final DateTime today = DateTime.now();
    // final Random random = Random();
    // for (int month = -1; month < 2; month++) {
    //   for (int day = -5; day < 5; day++) {
    //     for (int hour = 12; hour < 24; hour += 5) {
    //       meetingCollection.add(Meeting(
    //         from: today
    //             .add(Duration(days: (month * 30) + day))
    //             .add(Duration(hours: hour)),
    //         to: today
    //             .add(Duration(days: (month * 30) + day))
    //             .add(Duration(hours: hour + 2)),
    //         background: _colorCollection[random.nextInt(9)],
    //         startTimeZone: '',
    //         endTimeZone: '',
    //         description: '',
    //         isAllDay: false,
    //         eventName: eventNameCollection[random.nextInt(2)],
    //       ));
    //     }
    //   }
    // }
    // print(meetingCollection.isNotEmpty?"yaaaa":"naaaaa");

    return meetingCollection;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  String getEmail(int index) => appointments![index].email;
}

class Meeting {
  Meeting(
      {required this.from,
        required this.to,
        required this.email,
        this.background = const Color.fromRGBO(76, 175, 80, 1.0),
        this.isAllDay = false,
        this.eventName = '',
        this.startTimeZone = '',
        this.endTimeZone = '',
        this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
  final String email;
}