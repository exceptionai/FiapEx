import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewRowCallScreen extends StatefulWidget {
  @override
  _NewRowCallScreenState createState() => _NewRowCallScreenState();
}

class _NewRowCallScreenState extends State<NewRowCallScreen> {
  final GlobalKey<FormState> rowCallFormKey = new GlobalKey<FormState>();
  RollModel rollModel;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(
        action: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
            child: Image.asset('assets/images/entregatrabalhos.png', height: 26),
            onTap: () {
              Navigator.of(context).pushNamed('/assignment');
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: rowCallFormKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17.0),
                      child: Text(
                        "NOVA CHAMADA",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.text_format),
                      labelText: 'Pauta da aula',
                    ),
                    validator: (value) {
                      if(value.length < 5) {
                        return 'A pauta deve ter mais de cinco caracteres';
                      }
                      else if(value.isEmpty) {
                        return 'Preencha este campo.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.text_fields),
                      labelText: 'Observações',
                    ),
                    validator: (value) {
                      if(value.length < 10) {
                        return 'A descrição deve ter mais de dez caracteres.';
                      }
                      else if(value.isEmpty) {
                        return 'Acrescente detalhes ao conteúdo ministrado.';
                      }
                      return null;
                    },
                    onSaved: (value) {} 
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                    child: DropdownButtonFormField<String>(
                      hint: Text("Selecione a turma"),
                      items: ["3SIR", "3SIS", "3SIT"].map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                      validator: (String value) {
                        if (value?.isEmpty ?? true) {
                          return "Uma turma deve ser selecionada.";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      height: 200,
                      child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(2020, 6, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        // Do something
                      },
              ),
            ),
                  ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                      child: Text("Iniciar Chamada"),
                      onPressed: () {

                        if (rowCallFormKey.currentState.validate()) {
                          rowCallFormKey.currentState.save();

                          // Navigator.pop(
                          //   context,
                          //   cursoModel,
                          // );

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
