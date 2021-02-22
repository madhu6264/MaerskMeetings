import 'package:book_meetings/features/home/model/meeting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  String officeStartTime;
  String officeEndTime;
  bool notificationEnabled;
  SharedPreferences prefs;

  SettingsViewModel() {
    initPreferences();
  }

  initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    officeStartTime = await prefs.getString('officeStartTime') ?? "9:00 AM";
    officeEndTime = await prefs.getString('officeEndTime') ?? "5:00 PM";
    notificationEnabled =await prefs.getBool('notificationEnabled') ?? true;
    notifyListeners();
  }

  setOfficeStartTime(TimeOfDay time) async {
    await prefs.setString('officeStartTime', formatTimeOfDay(time));
    officeStartTime = formatTimeOfDay(time);
    notifyListeners();
  }

  setOfficeEndTime(TimeOfDay time) async {
    await prefs.setString('officeEndTime', formatTimeOfDay(time));
    officeEndTime = formatTimeOfDay(time);
    notifyListeners();
  }

  setNotificationStatus(bool status) async {
    await prefs.setBool('notificationEnabled', status);
    notificationEnabled = status;
    if(!status){
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.cancelAll();
    }
    notifyListeners();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

}
