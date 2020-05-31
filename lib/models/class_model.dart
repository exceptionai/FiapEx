
import 'package:FiapEx/repository/db_connection.dart';
import 'package:flutter/material.dart';

class ClassModel{
  
  int id;
  String name;
  final String idColumn = DbConnection.classTable["idColumn"];
  final String nameColumn = DbConnection.classTable["nameColumn"];

  ClassModel();

  ClassModel.withIdName(
    {@required this.id,
    @required this.name,}
  );

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