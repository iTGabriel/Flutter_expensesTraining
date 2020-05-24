import 'package:flutter/material.dart';


class TransactionForm extends StatefulWidget{

  final void Function(String, double) onSubmit;
  TransactionForm(this.onSubmit);

  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm(){
  final title = titleController.text;
  final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }

    widget.onSubmit(title, value);
  }

  
  Widget build(BuildContext context){
    return Column(children: <Widget>[
      TextField(controller: titleController, decoration: InputDecoration(labelText: 'Titulo'), onSubmitted: (_) => _submitForm()),
      TextField(controller: valueController, decoration: InputDecoration(labelText: 'Valor: (R\$)'), 
      keyboardType: TextInputType.numberWithOptions(decimal: true), onSubmitted: (_) => _submitForm(),),
      FlatButton(onPressed: () => _submitForm(), child: Text('Cadastrar despesa', style: TextStyle(color: Colors.red[400])),)
    ]);
  }
}