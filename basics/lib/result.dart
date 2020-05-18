import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String total;
  final Function reset;

  Result(this.total, this.reset);

  String get result {
    return 'Huhaaa: ' + this.total;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          'Done! : ' + result,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        FlatButton(
          child: Text('Go Back'),
          onPressed: this.reset,
        )
      ]),
    );
  }
}
