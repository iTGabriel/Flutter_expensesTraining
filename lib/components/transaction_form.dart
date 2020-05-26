import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionForm extends StatefulWidget{

  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedTime;

  _submitForm(){
  final title = titleController.text;
  final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedTime == null){
      return;
    }

    widget.onSubmit(title, value, _selectedTime);
  }

  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now())
      .then((dateSelected) {
        
        if(dateSelected == null) {
          return;
        }

        setState((){
        _selectedTime = dateSelected;

        });

        });
  }

  
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: <Widget>[
        TextField(controller: titleController, decoration: InputDecoration(labelText: 'Titulo'), onSubmitted: (_) => _submitForm()),
        TextField(controller: valueController, decoration: InputDecoration(labelText: 'Valor: (R\$)'), 
        keyboardType: TextInputType.numberWithOptions(decimal: true), onSubmitted: (_) => _submitForm(),),
        SizedBox(height: 20),
        Row(children:<Widget>[
           Expanded(
                        child: _selectedTime == null 
             ?Text("Nenhuma data selecionada ", style: Theme.of(context).textTheme.headline5.apply(color: Colors.black))
             :Text( "Data selecionada: " + DateFormat('d').format(_selectedTime) +"/"+ DateFormat('MM').format(_selectedTime) +'/'+ DateFormat('y').format(_selectedTime)),
           ) ,
          FlatButton(onPressed: _showDatePicker, child: Text("Selecionar data", style: Theme.of(context).textTheme.headline5.apply(color: Theme.of(context).primaryColor),),)
          ]),
        Padding(padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(15)),
            child:FlatButton(onPressed: () => _submitForm(), child: Text('Cadastrar despesa', style: Theme.of(context).textTheme.headline5))
          ),
        )
      ]),
    );
  }
}