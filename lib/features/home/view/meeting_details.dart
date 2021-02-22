import 'package:book_meetings/features/home/model/meeting_model.dart';
import 'package:book_meetings/features/home/view_model/home_viewmodel.dart';
import 'package:book_meetings/features/widgets/rounded_button.dart';
import 'package:book_meetings/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingDetailsPage extends StatelessWidget {
  final MeetingDetails details;

  MeetingDetailsPage({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: new BoxDecoration()),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.all(40.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.black26),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          details.title,
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          details.description,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 24,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              details.time_date,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  details.room,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.history,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  optionsDuration[details.duration ?? "30"] ??
                                      "30 min",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  top: 60.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                )
              ],
            ),
            RoundedEdgeButton(
                text: 'Cancel Meeting',
                onPress: () async {
                  Provider.of<HomeViewModel>(context, listen: false)
                      .delete(details);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    ));
  }
}
