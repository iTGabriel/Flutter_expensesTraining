import 'package:despesas_pessoais/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> transacaoRecente;

  Chart(this.transacaoRecente);
  
  List <Map<String, Object>> get groupTransactions{
    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;

      for (var item = 0; item < transacaoRecente.length; item++ ) {
          bool diaAtual =  transacaoRecente[item].date.day == weekDay.day;
          bool mesAtual =  transacaoRecente[item].date.month == weekDay.month;
          bool anoAtual =  transacaoRecente[item].date.year == weekDay.year;

          if(diaAtual && mesAtual && anoAtual){
            total += transacaoRecente[item].value;
          }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': total
      };
      
    } 
    );
  }

  Widget build(BuildContext context) {
    groupTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
      
    );
  }
}