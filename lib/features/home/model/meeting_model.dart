class MeetingDetails {
  int meetingId;
  String title;
  String description;
  String time_date;
  String room;
  String date;

  String duration;
  String priority;
  String reminder;
  int time_date_ms;

  MeetingDetails(
      {this.meetingId,
      this.title,
      this.description,
      this.time_date,
      this.duration,
      this.priority,
      this.reminder,
      this.room,
      this.date,
      this.time_date_ms});

  Map<String, dynamic> toMap() {
    return {
      'meetingId': meetingId,
      'title': title,
      'description': description,
      'time_date': time_date,
      'duration': duration,
      'priority': int.parse(priority),
      'reminder': reminder,
      'room': room,
      "date": date,
      "time_date_ms": time_date_ms
    };
  }



  factory MeetingDetails.fromMap(Map<String, dynamic> map) {
    return  MeetingDetails(
      meetingId: map['meetingId'],
      title: map['title'],
      description: map['description'],
      time_date: map['time_date'],
      date: map['date'],
      duration: map['duration'] ?? '30 min',
      priority: map['priority'].toString(),
      reminder: map['reminder'] ?? '15 min',
      room: map['room'],
      time_date_ms: map['time_date_ms'],
    );
  }



}
