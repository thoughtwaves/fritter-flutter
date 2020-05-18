import 'package:basics/answer.dart';
import 'package:basics/quiz.dart';
import 'package:basics/result.dart';
import 'package:flutter/material.dart';

import './question.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var _index = 0;
  //var _questions = ['what\'s up?', 'Aur kya?'];
  final _questions = const [
    {
      'q': 'hulala',
      'a': ['asd', 'gf', 'cc']
    },
    {
      'q': 'ek aur',
      'a': ['ee', 'aa', 'oo']
    }
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Mera aap."),
          ),
          body: _index < _questions.length
              ? Quiz(questions: _questions, answered: _answered, index: _index,)
              : Result(stringtotal, _reset)),
    );
  }

  String stringtotal = '';

  void _reset(){
    setState(() {
      stringtotal = '';
      _index = 0;
    });
  }

  void _answered(String total) {
      stringtotal += total; 
      setState(() {
        _index = (_index + 1);
      });
    print('hahaha');
  }
}
