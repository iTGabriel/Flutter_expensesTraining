import 'package:despesas_pessoais/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'ChartBar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class Chart extends StatelessWidget {
  final List<Transaction> transacaoRecente;

  Chart(this.transacaoRecente);

 

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;

      for (var item = 0; item < transacaoRecente.length; item++) {
        bool diaAtual = transacaoRecente[item].date.day == weekDay.day;
        bool mesAtual = transacaoRecente[item].date.month == weekDay.month;
        bool anoAtual = transacaoRecente[item].date.year == weekDay.year;

        if (diaAtual && mesAtual && anoAtual) {
          total += transacaoRecente[item].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'value': total};
    });
  }

  double get _weekTotalValue {
    return groupTransactions.fold(0, (totalSomado, item) {
      return totalSomado + item['value'];
      });
  }

  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_Br';
    initializeDateFormatting('pt_Br', null);

    // groupTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(padding: const EdgeInsets.all(10), child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transacaoRecente.length > 0 ? groupTransactions.map((item) {
          return Expanded(
            child:ChartBar(
                          label: item['day'].toString().toUpperCase(),
            value: item['value'],
            percentage:(item['value'] as double) / _weekTotalValue ,
          ));
        }).toList() : [] ,
      ),
    ));
  }
}
