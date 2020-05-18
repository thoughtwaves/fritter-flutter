import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String ans;
  final Function action;

  Answer(this.ans, this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blueGrey,
        child: Text(ans),
        onPressed: action,
      ),
    );
  }
}
