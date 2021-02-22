import 'package:book_meetings/features/home/view_model/home_viewmodel.dart';
import 'package:book_meetings/features/settings/view/settings_screen.dart';
import 'package:book_meetings/utils/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_meeting_form.dart';
import 'meetings_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).initializeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maersk Meetings'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Open Settings',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingsScreen()));

            },
          ),

        ],

      ),
      body: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              // const SizedBox(height: 24.0),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(
                  model.selectedDateLable,
                  textScaleFactor: 1,
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    final DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: model.selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2050));
                    if (pickedDate != null) {
                      model.selectedDate = pickedDate;
                      model.selectedDateLable =
                          DateFormat("dd-MMM-yyyy").format(pickedDate);
                      model.fetchMeetings();
                    }
                  },
                  child: Text(
                    'Change',
                    textScaleFactor: 1,
                    style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(),



              const SizedBox(height: 8.0),
              model.lstMeetings.length > 0
                  ? Expanded(
                      child: ListView.builder(

                          padding: const EdgeInsets.all(8),
                          itemCount: model.lstMeetings.length,

                          itemBuilder: (BuildContext context, int index) {
                            return MeetingCard(details: model.lstMeetings[index],cardColor:model.getMeetingCardColor(model.lstMeetings[index]));

                          },),
                    )
                  : EmptyState("You don't have any meetings for selected date!")
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return new BookMeetingForm();
                  },
                  fullscreenDialog: true));
        },
        tooltip: 'Add New Meeting',
        child: Icon(Icons.add),
      ),
    );
  }
}
