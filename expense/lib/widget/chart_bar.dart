import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percent;

  ChartBar(this.label, this.amount, this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
      children: <Widget>[
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
        Container(
          height: constraints.maxHeight * 0.7,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromARGB(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(height: constraints.maxHeight * 0.1 ,child: FittedBox(child: Text(label)))
      ],
    );
    },);
    
  }
}
