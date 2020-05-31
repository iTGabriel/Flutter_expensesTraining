import 'dart:io';
import 'package:flutter/material.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './components/chart.dart';
import './models/Transaction.dart';

main() => runApp(Despesas());

class Despesas extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(primaryColor: Colors.red[400], accentColor: Colors.red[400],

      appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
        headline6:  TextStyle(fontFamily: 'Dancing Script', fontSize: 27) 
      )),
      
      textTheme: ThemeData.light().textTheme.copyWith(
        headline6:  TextStyle(fontFamily: 'Raleway', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        headline5:  TextStyle(fontFamily: 'Raleway', color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      )));
  }
}

class HomePage extends StatefulWidget{
  createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Flutter 2', value: 20, date: DateTime.now().subtract(Duration(days: 5))),
  ];
  var _ChartORList = true;

  List <Transaction> get _transacaoRecente{
      return _transactions.where( (tr) {
        return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  

  _addTransaction(String title, double value, DateTime data){
    final newTransaction = Transaction(id: (this._transactions.length.toInt() + 1 ).toString(), title: title, value: value, date: data); 
    setState((){
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState((){
      _transactions.removeWhere((item) => item.id == id);
    });

  }

  _activeModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_){
      return TransactionForm(_addTransaction);
      });
  }

  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas - Flutter App"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          if(isLandScape)IconButton(icon: _ChartORList ? Icon(Icons.insert_chart) : Icon(Icons.list), onPressed: () => { setState(() {_ChartORList = !_ChartORList;}) }),
          IconButton(icon: Icon(Icons.add), onPressed: () => _activeModal(context))
          ],
      ),
      body: SingleChildScrollView( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          if(_ChartORList || !isLandScape)
            Chart(_transacaoRecente),
          if(!_ChartORList || !isLandScape)
            TransactionList(_transactions, _removeTransaction),
            
            ],
          )), 
          floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
            child: Icon(Icons.add,), onPressed: () => _activeModal(context)), 
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
