import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  final List transactionList;
  final void Function(String) transactionRemove;

  TransactionList(this.transactionList, this.transactionRemove);

  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

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
            // child: Container(
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.red[100]), borderRadius: BorderRadius.circular(7.5)),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(8),
                  child: Text(NumberFormat('R\$ #.00', 'pt-BR').format(transaction.value), style: Theme.of(context).textTheme.headline5),
                ),
                title: Text(transaction.title, style: Theme.of(context).textTheme.headline6),
                subtitle: Text(DateFormat('d ').format(transaction.date) + 'de ' + DateFormat('MMMM ').format(transaction.date) + 'de ' + DateFormat('y ').format(transaction.date), style: Theme.of(context).textTheme.headline6.apply(color: Colors.white38)),
                trailing: isLandScape
                ? FlatButton.icon(icon: Icon(Icons.delete), onPressed: () => transactionRemove(transaction.id), label: Text("Excluir"), textColor: Colors.white,)
                : IconButton(icon: Icon(Icons.delete), onPressed: () => transactionRemove(transaction.id), color: Colors.white)));
        }),
    );
  }
}
