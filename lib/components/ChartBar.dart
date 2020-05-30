import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  // final List<Map<String, Object>> groupTransactions = [];
  // ChartBar(groupTransactions);

  final String label;
  final double value;
  final double percentage;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        value > 0
            ? FittedBox(child: Text(NumberFormat('#.00', 'pt-BR').format(value)))
            : Text(NumberFormat('0,00', 'pt-BR').format(value)),
        SizedBox(height: 5),
        Container(
            height: 60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.0),
                        color: Color.fromRGBO(239, 83, 80, 0.2),
                        borderRadius: BorderRadius.circular(5))),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: 
                        BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            )),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
