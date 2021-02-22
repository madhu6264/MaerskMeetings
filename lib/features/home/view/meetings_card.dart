import 'package:book_meetings/features/home/model/meeting_model.dart';
import 'package:book_meetings/features/home/view/meeting_details.dart';
import 'package:book_meetings/utils/helper.dart';
import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {

MeetingDetails details;
Color cardColor;
  MeetingCard({this.details, this.cardColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MeetingDetailsPage(details: details)));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color:cardColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(details.title, style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),



                    SizedBox(height: 4,),
                    Text(details.description, style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          children: <Widget>[

                            Icon(Icons.access_time, size: 24,),
                            
                            SizedBox(width: 8,),
                            Text(details.time_date, style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
                        ),
                        SizedBox(width: 8,),
                        Row(
                          children: <Widget>[

                            Icon(Icons.location_on_outlined, size: 24,),
                            
                            SizedBox(width: 8,),
                            Text(details.room, style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[

                            Icon(Icons.label_important_outline, size: 24,),
                            
                            SizedBox(width: 8,),
                            Text(optionsPriority[details.priority], style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
                        ),
                        SizedBox(width: 8,),
                        Row(
                          children: <Widget>[

                            Icon(Icons.history, size: 24,),
                            
                            SizedBox(width: 8,),
                            Text(optionsDuration[details.duration ?? "30"] ?? "30 min", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}