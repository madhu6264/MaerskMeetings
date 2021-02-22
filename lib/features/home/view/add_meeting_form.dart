import 'package:book_meetings/features/home/view_model/home_viewmodel.dart';
import 'package:book_meetings/features/widgets/rounded_button.dart';
import 'package:book_meetings/utils/helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookMeetingForm extends StatefulWidget {
  @override
  _BookMeetingFormState createState() => _BookMeetingFormState();
}

class _BookMeetingFormState extends State<BookMeetingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meeting'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Consumer<HomeViewModel>(
                builder: (context, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 24.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          model.meetingDetails.title = term;
                        },
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add title',
                          labelText: 'Title *',
                        ),
                        maxLines: 1,
                        onChanged: (String value) {
                          model.meetingDetails.title = value;
                        },
                        onSaved: (String value) {
                          model.meetingDetails.title = value;
                        },
                        validator: validateString,
                      ),
                      const SizedBox(height: 24.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          model.meetingDetails.description = term;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add description',
                          labelText: 'Description *',
                        ),
                        maxLines: 5,
                        onChanged: (String value) {
                          model.meetingDetails.description = value;
                        },
                        onSaved: (String value) {
                          model.meetingDetails.description = value;
                        },
                        validator: validateString,
                      ),
                      const SizedBox(height: 24.0),
                      DateTimeField(
                        format: DateFormat("dd-MMM-yyyy h:mma"),
                        validator: validateDate,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Meeting Date Time',
                          labelText: 'Date / Time *',
                        ),
                        onChanged: (dt) {
                          model.meetingDetails.time_date =
                              DateFormat('h:mma').format(dt);
                          model.meetingDetails.time_date_ms =
                              dt.millisecondsSinceEpoch;

                          model.meetingDetails.date =
                              DateFormat('d/M/y').format(dt);
                        },
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: model.officeStartTime,

                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                      ),
                      const SizedBox(height: 24.0),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select Meeting Duration',
                              labelText: 'Meeting Duration',
                            ),
                            isEmpty: model.meetingDetails.duration == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: model.meetingDetails.duration,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    model.meetingDetails.duration = newValue;
                                    state.didChange(optionsDuration[newValue]);
                                  });
                                },
                                items: optionsDuration.entries
                                    .map<DropdownMenuItem<String>>(
                                        (MapEntry<String, String> e) =>
                                            DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(e.value),
                                            ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      FormField<String>(
                        validator: validateString,
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Choose Meeting Room',
                              labelText: 'Meeting Room *',
                            ),
                            isEmpty: model.meetingDetails.room == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: model.meetingDetails.room,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    model.meetingDetails.room = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: optionsRoom.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      FormField<String>(
                        validator: validateString,
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Choose Priority',
                              labelText: 'Priority *',
                            ),
                            isEmpty: model.meetingDetails.priority == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: model.meetingDetails.priority,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      model.meetingDetails.priority = newValue;
                                      state
                                          .didChange(optionsPriority[newValue]);
                                    });
                                  },
                                  items: optionsPriority.entries
                                      .map<DropdownMenuItem<String>>(
                                          (MapEntry<String, String> e) =>
                                              DropdownMenuItem<String>(
                                                value: e.key,
                                                child: Text(e.value),
                                              ))
                                      .toList()),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Set Reminder',
                              labelText: 'Reminder',
                            ),
                            isEmpty: model.meetingDetails.reminder == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: model.meetingDetails.reminder,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      model.meetingDetails.reminder = newValue;
                                      state
                                          .didChange(optionsReminder[newValue]);
                                    });
                                  },
                                  items: optionsReminder.entries
                                      .map<DropdownMenuItem<String>>(
                                          (MapEntry<String, String> e) =>
                                              DropdownMenuItem<String>(
                                                value: e.key,
                                                child: Text(e.value),
                                              ))
                                      .toList()),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      RoundedEdgeButton(
                          text: 'Submit',
                          onPress: () async {
                            if (_validate()) {
                              model.meetingDetails.meetingId =
                                  DateTime.now().millisecondsSinceEpoch;

                              model.showNotification();

                              await Provider.of<HomeViewModel>(context,
                                      listen: false)
                                  .bookMeeting();

                              Navigator.of(context).pop();
                            } else {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Please fill all mandatory fields marked as *'));

                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          }),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }

  bool _validate() {
    if (_formKey.currentState.validate()) {
      return true;
    } else
      return false;
  }
}
