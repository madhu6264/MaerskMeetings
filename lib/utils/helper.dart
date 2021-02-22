import 'package:intl/intl.dart';




final optionsDuration = {
  '15': '15 min',
  '30': '30 min',
  '45': '45 min',
  '60': '1 hr',
  '120': '2 hrs'
};



var optionsPriority = {
  '3': 'High',
  '2': 'Medium',
  '1': 'Low',

};

var optionsRoom = [
  "Room 1",
  "Room 2",
  "Room 3",
  "Room 4",
];

var optionsReminder = {
  '1440': '24 hrs',
  '30': '30 min',
  '15': '15 min',

};

String validateString(String value) {
  if (value == null) {
    return 'This field is required.';
  } else if (value.length == 0) {
    return 'This field is required.';
  } else {
    return null;
  }
}

String validateDate(DateTime value) {
  if (value == null) {
    return 'This field is required.';
  } else {
    return null;
  }
}


