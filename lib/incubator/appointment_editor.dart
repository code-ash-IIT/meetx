part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}


// Event event = Event(); // Create object of event

class AppointmentEditorState extends State<AppointmentEditor> {
  CalendarClient calendarClient = CalendarClient();
  // dynamic _startupEmail;
  // dynamic _mentorEmail;

  final databaseReference = FirebaseFirestore.instance;

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
        color: Color.fromRGBO(255, 255, 255, 1.0),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              leading: const Text(''),
              title: TextField(
                controller: TextEditingController(text: _subject),
                onChanged: (String value) {
                  _subject = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add title',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: Icon(
                  Icons.access_time,
                  color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
                ),
                title: Row(children: <Widget>[
                  const Expanded(
                    child: Text('All-day'),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: _isAllDay,
                            onChanged: (bool value) {
                              setState(() {
                                _isAllDay = value;
                              });
                            },
                          ))),
                ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                                intl.DateFormat('EEE, MMM dd yyyy')
                                    .format(_startDate),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != _startDate) {
                                setState(() {
                                  final Duration difference =
                                  _endDate.difference(_startDate);
                                  _startDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _startTime.hour,
                                      _startTime.minute,
                                      0);
                                  _endDate = _startDate.add(difference);
                                  _endTime = TimeOfDay(
                                      hour: _endDate.hour,
                                      minute: _endDate.minute);
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                              child: Text(
                                intl.DateFormat('hh:mm a').format(_startDate),
                                textAlign: TextAlign.right,
                              ),
                              onTap: () async {
                                final TimeOfDay? time =
                                await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: _startTime.hour,
                                        minute: _startTime.minute));

                                if (time != null && time != _startTime) {
                                  setState(() {
                                    _startTime = time;
                                    final Duration difference =
                                    _endDate.difference(_startDate);
                                    _startDate = DateTime(
                                        _startDate.year,
                                        _startDate.month,
                                        _startDate.day,
                                        _startTime.hour,
                                        _startTime.minute,
                                        0);
                                    _endDate = _startDate.add(difference);
                                    _endTime = TimeOfDay(
                                        hour: _endDate.hour,
                                        minute: _endDate.minute);
                                  });
                                }
                              })),
                    ])),
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                leading: const Text(''),
                title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                            child: Text(
                              intl.DateFormat('EEE, MMM dd yyyy').format(_endDate),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != _endDate) {
                                setState(() {
                                  final Duration difference =
                                  _endDate.difference(_startDate);
                                  _endDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _endTime.hour,
                                      _endTime.minute,
                                      0);
                                  if (_endDate.isBefore(_startDate)) {
                                    _startDate = _endDate.subtract(difference);
                                    _startTime = TimeOfDay(
                                        hour: _startDate.hour,
                                        minute: _startDate.minute);
                                  }
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                              child: Text(
                                intl.DateFormat('hh:mm a').format(_endDate),
                                textAlign: TextAlign.right,
                              ),
                              onTap: () async {
                                final TimeOfDay? time =
                                await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: _endTime.hour,
                                        minute: _endTime.minute));

                                if (time != null && time != _endTime) {
                                  setState(() {
                                    _endTime = time;
                                    final Duration difference =
                                    _endDate.difference(_startDate);
                                    _endDate = DateTime(
                                        _endDate.year,
                                        _endDate.month,
                                        _endDate.day,
                                        _endTime.hour,
                                        _endTime.minute,
                                        0);
                                    if (_endDate.isBefore(_startDate)) {
                                      _startDate =
                                          _endDate.subtract(difference);
                                      _startTime = TimeOfDay(
                                          hour: _startDate.hour,
                                          minute: _startDate.minute);
                                    }
                                  });
                                }
                              })),
                    ])),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(
                Icons.public,
                color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
              ),
              title: Text(_timeZoneCollection[_selectedTimeZoneIndex]),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _TimeZonePicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(Icons.lens,
                  color: _colorCollection[_selectedColorIndex]),
              title: Text(
                _colorNames[_selectedColorIndex],
              ),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _ColorPicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.subject,
                color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
              ),
              title: TextField(
                controller: TextEditingController(text: _notes),
                onChanged: (String value) {
                  _notes = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                ),
              ),
            ),
            // const Divider(
            //   height: 1.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   contentPadding: const EdgeInsets.all(5),
            //   leading: Icon(
            //     Icons.email,
            //     color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
            //   ),
            //   title: TextField(
            //     controller: TextEditingController(text: _startupEmail),
            //     onChanged: (dynamic value) {
            //       _startupEmail = value;
            //     },
            //     keyboardType: TextInputType.multiline,
            //     maxLines: null,
            //     style: TextStyle(
            //         fontSize: 18,
            //         color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
            //         fontWeight: FontWeight.w400),
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText: 'Startup email',
            //     ),
            //   ),
            // ),
            // const Divider(
            //   height: 1.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   contentPadding: const EdgeInsets.all(5),
            //   leading: Icon(
            //     Icons.email,
            //     color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
            //   ),
            //   title: TextField(
            //     controller: TextEditingController(text: _mentorEmail),
            //     onChanged: (dynamic value) {
            //       _mentorEmail = value;
            //     },
            //     keyboardType: TextInputType.multiline,
            //     maxLines: null,
            //     style: TextStyle(
            //         fontSize: 18,
            //         color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
            //         fontWeight: FontWeight.w400),
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText: "Mentor's email",
            //     ),
            //   ),
            // ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text(getTile()),
              backgroundColor: _colorCollection[_selectedColorIndex],
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    icon: const Icon(
                      Icons.done,
                      color: Color.fromRGBO(0, 0, 0, 0.8666666666666667),
                    ),
                    onPressed: () async {
                      List<EventAttendee> l = makeAttendeesList(startup_mail, mentor_mail);
                      calendarClient.insert(_subject, _startDate, _endDate, _selectedTimeZoneIndex==0?'':_timeZoneCollection[_selectedTimeZoneIndex], l);
                      final List<Meeting> meetings = <Meeting>[];
                      if (_selectedAppointment != null) {
                        _events.appointments!.removeAt(_events.appointments!
                            .indexOf(_selectedAppointment));
                        _events.notifyListeners(CalendarDataSourceAction.remove,
                            <Meeting>[]..add(_selectedAppointment!));
                      }
                      meetings.add(Meeting(
                        email: _prim_email,
                        from: _startDate,
                        to: _endDate,
                        background: _colorCollection[_selectedColorIndex],
                        startTimeZone: _selectedTimeZoneIndex == 0
                            ? ''
                            : _timeZoneCollection[_selectedTimeZoneIndex],
                        endTimeZone: _selectedTimeZoneIndex == 0
                            ? ''
                            : _timeZoneCollection[_selectedTimeZoneIndex],
                        description: _notes,
                        isAllDay: _isAllDay,
                        eventName: _subject == '' ? '(No title)' : _subject,
                      ));

                      //For Admin
                      final refDoc = databaseReference.collection("CalendarAppointmentCollection").doc(_prim_email);
                      final doc = await refDoc.get();
                      if(!doc.exists){
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(_prim_email)
                            .set({
                          _subject : {
                            'Email': _prim_email,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }
                      else{
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(_prim_email)
                            .update({
                          _subject : {
                            'Email': _prim_email,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }

                      //For Startup
                      final refDocStartup = databaseReference.collection("CalendarAppointmentCollection").doc(startup_mail);
                      final docStartup = await refDocStartup.get();
                      if(!docStartup.exists){
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(startup_mail)
                            .set({
                          _subject : {
                            'Email': startup_mail,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }
                      else{
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(startup_mail)
                            .update({
                          _subject : {
                            'Email': startup_mail,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }

                      //For Mentor
                      final refDocMentor = databaseReference.collection("CalendarAppointmentCollection").doc(mentor_mail);
                      final docMentor = await refDocMentor.get();
                      if(!docMentor.exists){
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(mentor_mail)
                            .set({
                          _subject : {
                            'Email': mentor_mail,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }
                      else{
                        databaseReference.collection("CalendarAppointmentCollection")
                            .doc(mentor_mail)
                            .update({
                          _subject : {
                            'Email': mentor_mail,
                            'From': _startDate,
                            'To':_endDate,
                            // 'Background':_colorCollection[_selectedColorIndex],
                            'StartTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'EndTimeZone':_selectedTimeZoneIndex == 0
                                ? ''
                                : _timeZoneCollection[_selectedTimeZoneIndex],
                            'Description':_notes,
                            'isAllDay':_isAllDay,
                            'Event Name':_subject == '' ? '(No title)' : _subject,
                          }

                        });
                      }

                      // event.summary = _notes; //Setting summary of object
                      //
                      // EventDateTime start = new EventDateTime(); //Setting start time
                      // start.dateTime = _startDate;
                      // start.timeZone = _selectedTimeZoneIndex == 0
                      //     ? ''
                      //     : _timeZoneCollection[_selectedTimeZoneIndex];
                      // event.start = start;
                      //
                      // EventDateTime end = new EventDateTime(); //Setting start time
                      // end.dateTime = _endDate;
                      // end.timeZone = _selectedTimeZoneIndex == 0
                      //     ? ''
                      //     : _timeZoneCollection[_selectedTimeZoneIndex];
                      // event.end = end;
                      //
                      //
                      //////////////////////////////////////////////

                      _events.appointments!.add(meetings[0]);

                      _events.notifyListeners(
                          CalendarDataSourceAction.add, meetings);
                      _selectedAppointment = null;

                      Navigator.pop(context);
                    })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
            floatingActionButton: _selectedAppointment == null
                ? const Text('')
                : FloatingActionButton(
              onPressed: () {
                if (_selectedAppointment != null) {
                  _events.appointments!.removeAt(_events.appointments!
                      .indexOf(_selectedAppointment));
                  _events.notifyListeners(CalendarDataSourceAction.remove,
                      <Meeting>[]..add(_selectedAppointment!));
                  _selectedAppointment = null;
                  Navigator.pop(context);
                }
              },
              child:
              const Icon(Icons.delete_outline, color: Color.fromRGBO(0, 0, 0, 1)),
              backgroundColor: Color.fromRGBO(255, 0, 0, 1),
            )));
  }

  String getTile() {
    return _subject.isEmpty ? 'New event' : 'Event details';
  }

  List<EventAttendee> makeAttendeesList(dynamic startup, dynamic mentor){
    List<EventAttendee> lst = <EventAttendee>[];
    EventAttendee st = EventAttendee();
    st.email = startup;
    EventAttendee mn = EventAttendee();
    mn.email = mentor;
    lst.add(st);
    lst.add(mn);
    return lst;
  }
}