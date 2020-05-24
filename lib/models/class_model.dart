import 'package:FiapEx/repository/db_conection.dart';

class ClassModel{
  
  int id;
  String name;
  final String idColumn = DbConection.classTable["idColumn"];
  final String nameColumn = DbConection.classTable["nameColumn"];

  ClassModel();

  ClassModel.fromMap(Map map){
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
    return "class (id: $id, name: $name)";
  }


}