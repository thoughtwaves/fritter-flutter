import 'package:flutter/material.dart';

import 'package:basics/answer.dart';
import 'package:basics/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answered;
  final int index;

  Quiz({this.questions, this.answered, this.index});


  @override
  Widget build(BuildContext context) {
    return Column(
                  children: <Widget>[
                    Question(questions.elementAt(index)['q']),
                    ...(questions[index]['a'] as List<String>).map((ans) {
                      return Answer(ans, () => answered(ans));
                    }).toList(),
                  ],
                );
  }
}