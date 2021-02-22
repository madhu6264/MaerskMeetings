import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String msg;

  EmptyState(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Text(
      '$msg',

    )));
  }
}
