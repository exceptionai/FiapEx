
import 'package:FiapEx/repository/db_connection.dart';

class DisciplineModel{
  
  int id;
  String name;
  final String idColumn = DbConnection.disciplineTable["idColumn"];
  final String nameColumn = DbConnection.disciplineTable["nameColumn"];

  DisciplineModel();

  DisciplineModel.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      nameColumn : name
    };
    return map;
  }

  @override
  String toString(){
    return "Discipline (id: $id, name: $name)";
  }


}