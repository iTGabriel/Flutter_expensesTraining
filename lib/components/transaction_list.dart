import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  final List transactionList;

  TransactionList(this.transactionList);

  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_Br';
    initializeDateFormatting('pt_Br', null);

    return Container(
      height: 300,
      child: 
      transactionList.isEmpty 
      ? Column(children: <Widget>[
        SizedBox(height: 20),
        Text("Lista vazia, nenhum registro para ser exibido", style: Theme.of(context).textTheme.headline6.apply(color: Colors.black)),
        SizedBox(height: 20),
        Image.asset('assets/images/zzz.png')])
      : ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
            final transaction = transactionList[index];
          return Card(
            elevation: 5,
            color: Theme.of(context).primaryColor,
            child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.red[100])),
              padding: EdgeInsets.all(10),
              child: Text(NumberFormat('R\$ #.00', 'pt-BR').format(transaction.value), style: Theme.of(context).textTheme.headline5)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(transaction.title, style: Theme.of(context).textTheme.headline6),
                Text(DateFormat('d ').format(transaction.date) + 'de ' + DateFormat('MMMM ').format(transaction.date) + 'de ' + DateFormat('y ').format(transaction.date), style: Theme.of(context).textTheme.headline6.apply(color: Colors.white38)),
                ])
                ]));
        }),
    );
  }
}
