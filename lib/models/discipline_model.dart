
import 'package:FiapEx/repository/db_connection.dart';
import 'package:flutter/material.dart';

class DisciplineModel{
  
  int id;
  String name;
  final String idColumn = DbConnection.disciplineTable["idColumn"];
  final String nameColumn = DbConnection.disciplineTable["nameColumn"];

  DisciplineModel();

  @override
  int get hashCode{
    return id;
  }

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return id == other.id;
  }

  DisciplineModel.withIdName(
    {@required this.id,
    @required this.name}
  );

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