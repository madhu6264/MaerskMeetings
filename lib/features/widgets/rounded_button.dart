import 'package:flutter/material.dart';

class RoundedEdgeButton extends StatelessWidget {
  final String text;
  final Function onPress;

  RoundedEdgeButton({this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
          onPressed: onPress,
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
