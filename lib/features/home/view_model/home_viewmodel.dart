import 'dart:convert';
import 'dart:math';

import 'package:book_meetings/features/home/model/meeting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeViewModel extends ChangeNotifier {
  String selectedDateLable;
  TimeOfDay officeStartTime;
  DateTime selectedDate;
  List<MeetingDetails> lstMeetings = [];

  MeetingDetails meetingDetails = new MeetingDetails();

  HomeViewModel() {
    selectedDateLable = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    getOfficeStartTime();
    tz.initializeTimeZones();

    fetchMeetings();
  }

  static const databaseName = 'maersk_meetings.db';
  static Database _database;
  static const tableName = "meetings";

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDB();
    } else {
      return _database;
    }
  }

  initializeDB() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE ${tableName}(id INTEGER PRIMARY KEY AUTOINCREMENT, meetingId INTEGER, title TEXT, description TEXT, time_date TEXT,  date TEXT, time_date_ms INTEGER, room TEXT, duration TEXT,  priority INTEGER, reminder TEXT)');
    });
  }

  fetchMeetings() async {
    final Database db = await database;
    final List<Map<String, dynamic>> list = await db.query(
      tableName,
      where:
          'date = "${DateFormat('d/M/y').format(selectedDate == null ? DateTime.now() : selectedDate)}"',
      orderBy: "time_date_ms ASC, priority DESC",
    );

    lstMeetings =
        List<MeetingDetails>.from(list.map((x) => MeetingDetails.fromMap(x)));
    notifyListeners();
  }

  bookMeeting({MeetingDetails details}) async {
    final Database db = await database;
    db.insert(tableName, meetingDetails.toMap());
    meetingDetails = new MeetingDetails();
    fetchMeetings();
  }

  update(MeetingDetails details) async {
    final Database db = await database;
    db.update(tableName, details.toMap(),
        where: 'meetingId = ?', whereArgs: [details.meetingId]);
    notifyListeners();
  }

  delete(MeetingDetails details) async {
    final Database db = await database;
    var status = db.delete(tableName,
        where: 'meetingId = ?', whereArgs: [details.meetingId]);
    fetchMeetings();
  }

  Color getMeetingCardColor(MeetingDetails details) {
    switch (details.room) {
      case "Room 1":
        {
          return Colors.green[300];
        }
        break;

      case "Room 2":
        {
          return Colors.blueGrey[300];
        }
        break;

      case "Room 3":
        {
          return Colors.red[300];
        }
        break;

      case "Room 4":
        {
          return Colors.cyan[300];
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  //Notifications

  Future showNotification() async {
    var initializationSettingsAndroid = new AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'Maersk',
      'Maersk',
      'Maersk',
      importance: Importance.max,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    try {
      var time = tz.TZDateTime.from(
        (DateTime.fromMillisecondsSinceEpoch(meetingDetails.time_date_ms))
            .subtract(Duration(minutes: int.parse(meetingDetails.reminder))),
        tz.local,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool notificationsEnabled =
          await prefs.getBool('notificationEnabled') ?? true;
      if (notificationsEnabled) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            Random().nextInt(1000),
            meetingDetails.title,
            meetingDetails.description,
            time,
            platformChannelSpecifics,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true);
      }
    } catch (e) {
      print(e);
    }
  }

  Future onSelectNotification(String payload) async {
    //Custom payload handling
  }

  getOfficeStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String startTime = await prefs.getString('officeStartTime') ?? "9:00 AM";

    final format = DateFormat.jm();
    officeStartTime = TimeOfDay.fromDateTime(format.parse(startTime));
  }
}
