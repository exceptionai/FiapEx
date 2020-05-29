import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/repository/class_repository.dart';
import 'package:FiapEx/repository/discipline_repository.dart';
import 'package:FiapEx/repository/rollRegister_repository.dart';
import 'package:FiapEx/repository/student_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RowCallHistoryTile extends StatefulWidget {

  RollModel rowCallHistory;

  RowCallHistoryTile(this.rowCallHistory){}

  @override
  _RowCallHistoryTileState createState() => _RowCallHistoryTileState();
}

class _RowCallHistoryTileState extends State<RowCallHistoryTile> {
  ClassRepository classRepository = new ClassRepository();
  StudentRepository studentRepository = new StudentRepository();

  DisciplineRepository disciplineRepository = new DisciplineRepository();
  RollRegisterRepository rollRegisterRepository = new RollRegisterRepository();

  ClassModel rowCallClass;

  DisciplineModel rowCallDiscipline;
  int rowCallPresentStudentsCount;
  int studentsCount;

  @override
  void initState() { 
    super.initState();
    
    getRowCallHistoryClass();
    getRowCallDiscipline();
    getRowCallPresentStudentsCount();
    getRowCallStudentsCount();
  }

  getRowCallStudentsCount() async{
    List students = await studentRepository.getAllStudents();
    studentsCount = students.length;
    setState((){});
  }

  getRowCallPresentStudentsCount() async{
    rowCallPresentStudentsCount = await rollRegisterRepository.presentStudentsCount(widget.rowCallHistory.id);
    setState((){});
  }

  getRowCallHistoryClass() async{
    rowCallClass = await classRepository.getClass(widget.rowCallHistory.idClass);
    setState((){});
  }

  getRowCallDiscipline() async{
    rowCallDiscipline = await disciplineRepository.getDiscipline(widget.rowCallHistory.idDiscipline);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(bottom: 15),
      child: Theme(
        data: Theme.of(context).copyWith(textTheme: TextTheme(
          subtitle1:  TextStyle(color: Colors.white,fontSize: 20,
          fontFamily: 'GothamHTF',),
        ),),
              child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/rowcall');
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${rowCallDiscipline != null ? rowCallDiscipline.name : ''} - ${rowCallClass != null ? rowCallClass.name : ''}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Text('Data: ', style: TextStyle(fontSize: 14)),
                  Text('${DateFormat('dd/MM/yyyy').format(widget.rowCallHistory.date)}', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Status: ', style: TextStyle(fontSize: 14)),
                  Text('${widget.rowCallHistory.done ? 'Finalizado' : 'Pendente'}', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Alunos: ', style: TextStyle(fontSize: 14)),
                  Text('${studentsCount != null ? studentsCount : ''}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.lightBlueAccent)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ausentes: ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text('${rowCallPresentStudentsCount != null && studentsCount != null ? studentsCount - rowCallPresentStudentsCount  : ''}',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Presentes: ', style: TextStyle(fontSize: 14)),
                  Text('${rowCallPresentStudentsCount != null ? rowCallPresentStudentsCount : ''} ',
                      style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
                ],
              )
            ],
          ),
          leading: 
             widget?.rowCallHistory?.done != null && widget.rowCallHistory.done ? Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Image.asset(
                    'assets/images/presenteicone.png',
                    width: 40,
                  ),
              )
              : Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Image.asset(
                    'assets/images/pendenteicone.png',
                    width: 40,
                  ),
              ),
        ),
      ),
    );
  }
}
