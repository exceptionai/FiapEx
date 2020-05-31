import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/repository/rollRegister_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewRowCallScreen extends StatefulWidget {
  @override
  _NewRowCallScreenState createState() => _NewRowCallScreenState();
}

class _NewRowCallScreenState extends State<NewRowCallScreen> {
  final GlobalKey<FormState> rowCallFormKey = new GlobalKey<FormState>();
  RollModel rollModel = new RollModel();
  RollRepository repository = new RollRepository();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(
        action: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child:
                Image.asset('assets/images/entregatrabalhos.png', height: 26),
            onTap: () {
              Navigator.of(context).pushNamed('/assignment');
            },
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: rowCallFormKey,
              child: Center(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Theme.of(context).primaryColor,
                  ),
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
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                        child: DropdownButtonFormField<ClassModel>(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          hint: Text("Selecione a turma"),
                          items: [
                            ClassModel.withIdName(id: 1, name: "1TDSS"),
                            ClassModel.withIdName(id: 2, name: "3SIT"),
                            ClassModel.withIdName(id: 3, name: "3SIR")
                          ]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.name),
                                    value: ClassModel(),
                                  ))
                              .toList(),
                          validator: (ClassModel value) {
                            if (value == null) {
                              return "Uma turma deve ser selecionada.";
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          onChanged: (value) {
                            rollModel.idClass = value.id;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                        child: DropdownButtonFormField<DisciplineModel>(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          hint: Text("Selecione a matéria"),
                          items: [
                            DisciplineModel.withIdName(
                                id: 1, name: "Denvolvimento Cross Platform"),
                            DisciplineModel.withIdName(
                                id: 1, name: "Desenvolvimento Mobile Híbrido")
                          ]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.name),
                                    value: label,
                                  ))
                              .toList(),
                          validator: (DisciplineModel value) {
                            if (value == null) {
                              return "Uma matéria deve ser selecionada.";
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          onChanged: (value) {
                            rollModel.idDiscipline = value.id;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Container(
                          height: 200,
                          child: Theme(
                            data: ThemeData(
                              cupertinoOverrideTheme: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  pickerTextStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                            child: CupertinoDatePicker(
                              onDateTimeChanged: (DateTime newdate) {
                                rollModel.date = newdate;
                              },
                              use24hFormat: true,
                              maximumDate: new DateTime(2022, 12, 30),
                              minimumYear: 2010,
                              initialDateTime: DateTime.now(),
                              minuteInterval: 1,
                              mode: CupertinoDatePickerMode.date,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("Iniciar Chamada"),
                          onPressed: () {
                            if (rowCallFormKey.currentState.validate()) {
                              rowCallFormKey.currentState.save();
                              repository.saveRoll(rollModel);

                              Navigator.of(context).pushReplacementNamed(
                                '/rowcall',
                                arguments: rollModel,
                              );
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
        ),
      ),
    );
  }
}
