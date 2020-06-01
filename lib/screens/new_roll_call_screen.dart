import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/services/row_call_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewRowCallScreen extends StatefulWidget {
  @override
  _NewRowCallScreenState createState() => _NewRowCallScreenState();
}

class _NewRowCallScreenState extends State<NewRowCallScreen> {
  final GlobalKey<FormState> rowCallFormKey = new GlobalKey<FormState>();
  RollModel rollModel = new RollModel();
  RowCallService service = new RowCallService();
  List<ClassModel> studentClasses = List<ClassModel>();
  List<DisciplineModel> disciplines = List<DisciplineModel>();
  bool loadingDropDown = false;

  @override
  void initState() {
    super.initState();
    getStudentClasses();
  }

  getStudentClasses() async {
    studentClasses = await service.getAllClasses();
    setState(() {});
  }

  getDisciplines({int classId}) async {
    setState(() {
      loadingDropDown = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    disciplines = await service.getAllDisciplinesByClass(classId: classId);
    setLoading(false);
  }

  setLoading(bool value) {
    setState(() {
      {
        loadingDropDown = value;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFiapEx(
          action: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child:
                  Image.asset('assets/images/entregatrabalhos.png', height: 26),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/assignment');
              },
            ),
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: buildForm(context),
                ))));
  }

  Form buildForm(BuildContext context) {
    return Form(
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
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                child: buildDropdownButtonForClass(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
                child: buildDropdownButtonForDiscipline(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  height: 200,
                  child: buildCupertinoDatePicker(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildRaisedButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton buildRaisedButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        "Iniciar Chamada",
        style: TextStyle(color: Colors.white, fontSize: 17.0),
      ),
      onPressed: () {
        if (rowCallFormKey.currentState.validate()) {
          rowCallFormKey.currentState.save();
          saveRowCall();
        }
      },
    );
  }

  Widget buildCupertinoDatePicker() {
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
                TextStyle(color: Colors.white, fontSize: 16),
            pickerTextStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      child: CupertinoDatePicker(
        onDateTimeChanged: (DateTime newdate) {
          rollModel.date = newdate;
        },
        use24hFormat: true,
        maximumDate: DateTime.now(),
        minimumYear: 2010,
        initialDateTime: DateTime.now().subtract(Duration(seconds: 10)),
        minuteInterval: 1,
        mode: CupertinoDatePickerMode.date,
      ),
    );
  }

  DropdownButtonFormField<ClassModel> buildDropdownButtonForClass() {
    return DropdownButtonFormField<ClassModel>(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      iconEnabledColor: Colors.white,
      hint: Text("Selecione a turma", style: TextStyle(fontSize: 17.0)),
      items: studentClasses
          .map((label) => DropdownMenuItem(
                child: Text(label.name),
                value: label,
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
        setLoading(true);
        getDisciplines(classId: value.id);
      },
    );
  }

  Widget buildDropdownButtonForDiscipline() {
    if (loadingDropDown) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      );
    }
    return DropdownButtonFormField<DisciplineModel>(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: disciplines.isEmpty ? Colors.grey[800] : Colors.white)),
      ),
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.grey[800],
      hint: Text(
        "Selecione a matéria",
        style: TextStyle(
            fontSize: 17.0,
            color: disciplines.isEmpty ? Colors.grey[800] : Colors.white),
      ),
      items: disciplines
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
      onChanged: disciplines == null
          ? null
          : (value) {
              rollModel.idDiscipline = value.id;
            },
    );
  }

  saveRowCall() async {
    RollModel updatedModel = await service.createRowCall(rollModel);

    Navigator.of(context).pushReplacementNamed(
      '/rowcall',
      arguments: updatedModel,
    );
  }
}
