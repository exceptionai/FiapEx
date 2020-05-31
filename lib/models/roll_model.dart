
import 'package:FiapEx/repository/db_connection.dart';
import 'package:intl/intl.dart';

class RollModel{
  
  int id;
  DateTime date = DateTime.now();
  bool done = false;
  int idClass;
  int idDiscipline;

  final Map<int,String> weekDay = {
    1 : 'Segunda-Feira',
    2 : 'Terça-Feira',
    3 : 'Quarta-Feira',
    4 : 'Quinta-Feira',
    5 : 'Sexta-Feira'
  };

  final String idColumn = DbConnection.rollTable["idColumn"];
  final String dateColumn = DbConnection.rollTable["dateColumn"];
  final String doneColumn = DbConnection.rollTable["doneColumn"];
  final String idClassColumn = DbConnection.rollTable["fkClassColumn"];
  final String idDisciplineColumn = DbConnection.rollTable["fkDisciplineColumn"];
  


  RollModel();

  RollModel.fromMap(Map map){
    id = map[idColumn];
    date = DateTime.parse(map[dateColumn]);
    if (map[doneColumn] == "Y"){
      done = true;
    }else if (map[doneColumn] == "N"){
      done = false;
    }else{
      done = null;
    }
    idClass = map[idClassColumn];
    idDiscipline = map[idDisciplineColumn];
  }

  String formatDate(DateTime date){
    var newFormat = DateFormat("yyyy-MM-dd");
    String newDate = newFormat.format(date).toString();
    return newDate;
  }

  String formatDone(bool done){
    String aux;
    if (done){
      aux = "Y";
    }else if(!done){
      aux = "N";
    }else{
      aux = "";
    }
    return aux;
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      dateColumn : formatDate(date),
      doneColumn : formatDone(done),
      idClassColumn : idClass,
      idDisciplineColumn : idDiscipline
    };
    return map;
  }

  @override
  String toString(){
    return """Roll (id: $id, date: $date, done: $done,
       idClass: $idClassColumn, idDiscipline : $idDisciplineColumn)""";
  }


}