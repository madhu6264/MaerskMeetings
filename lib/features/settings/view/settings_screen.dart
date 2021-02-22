import 'package:book_meetings/features/settings/view_model/settings_viewmodel.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final format = DateFormat("hh:mm a");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<SettingsViewModel>(
          builder: (context, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16, top: 16, bottom: 8),
                  child: Text(
                    'Office Timings',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
                Material(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          "From:",
                        ),
                        title: Text(
                          model.officeStartTime,
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            TimeOfDay selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child,
                                );
                              },
                            );

                            if (selectedTime != null) {
                              model.setOfficeStartTime(selectedTime);
                            }
                          },
                          child: Text(
                            'Change',
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Text(
                          "To:",
                        ),
                        title: Text(
                          model.officeEndTime,
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            TimeOfDay selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child,
                                );
                              },
                            );

                            if (selectedTime != null) {
                              model.setOfficeEndTime(selectedTime);
                            }
                          },
                          child: Text(
                            'Change',
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, bottom: 16, right: 16, left: 16),
                  child: Text(
                    'General',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
                Material(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SwitchListTile.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          title: Text(
                            'Allow Notifications',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          value: model.notificationEnabled,
                          onChanged: (bool newValue) {
                            model.setNotificationStatus(newValue);
                          }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
