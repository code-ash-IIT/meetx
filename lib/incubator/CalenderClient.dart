// import 'dart:developer';

import 'dart:html';
import 'dart:math';
import 'calendar.dart';

import 'package:flutter/material.dart';
// import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:googleapis_auth/auth_browser.dart" as auth;

class CalendarClient {
  static const _scopes = const [CalendarApi.calendarScope];

  insert(title, startTime, endTime, timezone, List<EventAttendee>attendeesEmail) {
    var _clientID = new auth.ClientId("867988330689-111rqbs6uom0a48o3bb9keqm5l9kd0a4.apps.googleusercontent.com", "");

    auth.createImplicitBrowserFlow(_clientID, _scopes).then((auth.BrowserOAuth2Flow flow) {
      flow.clientViaUserConsent().then((auth.AuthClient client) {
        print("Method Called");
        var calendar = CalendarApi(client);
        calendar.calendarList.list().then((value) =>
            print("VAL________$value"));

        // String calendarId = calendar.calendarList.list() as String;
        String calendarId = "primary";
        Event event = Event(); // Create object of event

        event.summary = title;

        EventDateTime start = new EventDateTime();
        start.dateTime = startTime;
        start.timeZone = timezone;
        event.start = start;

        EventDateTime end = new EventDateTime();
        end.timeZone = timezone;
        end.dateTime = endTime;
        event.end = end;

        event.attendees = attendeesEmail;
        try {
          calendar.events.insert(event, calendarId).then((value) {
            print("ADDEDDD_________________${value.status}");
            if (value.status == "confirmed") {
              // log('Event added in google calendar');
              print("Event added in google calendar");
            } else {
              // log("Unable to add event in google calendar");
              print("Unable to add event in google calendar");
            }
          });
        } catch (e) {
          // log('');
          print("Error creating event $e");
        }

        // var eventfetch = calendar.events;
        //
        // var eventsfetch = eventfetch.list(calendarId);
        //
        // eventsfetch.then((showEvents) {
        //   showEvents.items?.forEach((Event ev) { print(ev.summary); });
        //   querySelector("#text2")?.text = showEvents.toString();
        // });
        //
        //
        // client.close();
        // flow.close();
        //https://stackoverflow.com/questions/27235387/using-the-googleapis-library-in-dart-to-update-a-calendar-and-display-it-on-a-we
      });
    });
  }


  // getEvents(List<Color> _colorCollection) {
  //
  //   final List<Meeting> meetingCollectionHere = <Meeting>[];
  //   final Random random = Random();
  //
  //   var _clientID = new auth.ClientId("867988330689-111rqbs6uom0a48o3bb9keqm5l9kd0a4.apps.googleusercontent.com", "");
  //
  //   auth.createImplicitBrowserFlow(_clientID, _scopes).then((auth.BrowserOAuth2Flow flow) {
  //     flow.clientViaUserConsent().then((auth.AuthClient client) {
  //       print("Method Called");
  //       var calendar = CalendarApi(client);
  //       calendar.calendarList.list().then((value) =>
  //           print("VAL________$value"));
  //
  //       // String calendarId = calendar.calendarList.list() as String;
  //       String calendarId = "primary";
  //
  //       var eventfetch = calendar.events;
  //
  //       var eventsfetch = eventfetch.list(calendarId);
  //
  //       eventsfetch.then((showEvents) {
  //         // _colorCollection = <Color>[];
  //         showEvents.items?.forEach((Event ev) {
  //           meetingCollectionHere.add(
  //             Meeting(
  //                 from: ev.start?.dateTime as DateTime,
  //                 to: ev.end?.dateTime as DateTime,
  //               background: _colorCollection[random.nextInt(9)],
  //               startTimeZone: ev.start?.dateTime?.timeZoneName as String,
  //               endTimeZone: ev.end?.dateTime?.timeZoneName as String,
  //               description: '',
  //               isAllDay: false,
  //               eventName: ev.summary as String,
  //             ));
  //           print(ev.summary);
  //         });
  //         querySelector("#text2")?.text = showEvents.toString();
  //       });
  //
  //
  //       client.close();
  //       flow.close();
  //       //https://stackoverflow.com/questions/27235387/using-the-googleapis-library-in-dart-to-update-a-calendar-and-display-it-on-a-we
  //     });
  //   });
  //   print(meetingCollectionHere.isNotEmpty?"yaaaa":"naaaaa");
  //   return meetingCollectionHere;
  // }
}

/// Note:::: i have used calendar/v3.dart package to understand things this package is already included in GoogleApi package
/// you can access the package as i have told above
// import 'dart:developer';
// import 'dart:io' show Platform;

// import "package:googleapis_auth/auth_io.dart";
// import 'package:googleapis/calendar/v3.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CalendarClient {
//   var _credentials;

//   static const _scopes = const [CalendarApi.CalendarEventsScope];

//   insert(context, title, date, startTime, endTime) {
// if (Platform.isAndroid) {
//   _credentials = new ClientId(
//       "878169543212-ugngo0bm18hu3lh83nk76bidts9c4q2r.apps.googleusercontent.com",
//       "");
// } else if (Platform.isIOS) {
//   _credentials = new ClientId(
//       "126777344627-ibdaobtrs4n62a0l7h19fs04h73pbqqf.apps.googleusercontent.com",
//       "");
// }

//     if (_credentials != null) {
//       clientViaUserConsent(_credentials, _scopes, prompt)
//           .then((AuthClient client) {
//         var calendar = CalendarApi(client);

//         String calendarId =
//             "primary"; //"primary "If you want to work on primary calender of logged in user
//         //but if you want to get any other calendar of logged in user
//         //use following code to get list of all calendar and then work on
//         //calendar.calendarList.list(); //this will return list of all calendars of logged in user
//         //you can then fetch calendarID of specific calendar by asking the user
//         Event event = Event(); // Create object of event

//         event.summary = title;
//         //event.description="OPTIMEET TEST 1";

//         DateTime startDateTime = DateTime.parse("$date $startTime");
//         EventDateTime start = new EventDateTime();
//         start.dateTime = startDateTime;
//         start.timeZone = "GMT+05:00";

//         event.start = start;

//         DateTime endDateTime = DateTime.parse("$date $endTime");
//         EventDateTime end = new EventDateTime();
//         end.timeZone = "GMT+05:00";
//         end.dateTime = endDateTime;

//         event.end = end;

//         // set description of event. You can set more things like date created
//         // to check what you can add else open the implementation of calendar/v3.dart package and go to Event class
//         // you can direct open the class implementation by placing the cursor over Event() (where object is created above)
//         // for android studio press Ctrl + Alt + B , for vs code press f12
//         // in the implementation they have provided comments and documents that can help you understand

//         try {
//           calendar.events.insert(event, calendarId).then((value) {
//             print("ADDEDDD_________________${value.status}");
//             if (value.status == "confirmed") {
//               // Dialogs().displayToast(
//               //     context, "Event added in google calendar", 0);
//               log('Event added in google calendar');
//             } else {
//               log("Unable to add event in google calendar");
//               // Dialogs().displayToast(
//               //     context, "Unable to add event in google calendar", 0);
//             }
//           });
//         } catch (e) {
//           log('Error creating event $e');
//           // Dialogs().displayToast(context, e, 0);
//         } // function to insert event
//         // incase of any confusion i will recommed to go to implementation of calendar/v3.dart
//         // and read comments of their codez
//       });
//     }
//   }

//   void prompt(String url) async {
//     print("Please go to the following URL and grant access:");
//     print("  => $url");
//     print("");

//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }

// /// Note:::: i have used calendar/v3.dart package to understand things this package is already included in GoogleApi package
// /// you can access the package as i have told above