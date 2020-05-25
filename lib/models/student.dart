import 'package:FiapEx/repository/db_connection.dart';

class StudentModel{
  
  int id;
  String name;
  int idClass;
  String imgUrl;

  final String idColumn = DbConnection.studentTable["idColumn"];
  final String nameColumn = DbConnection.studentTable["nameColumn"];
  final String idClassColumn = DbConnection.studentTable["fkClassColumn"];
  final String imgUrlColumn = DbConnection.studentTable["imgUrlColumn"];

  StudentModel();

  StudentModel.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    idClass = map[idClassColumn];
    imgUrl = map[imgUrlColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      nameColumn : name,
      idClassColumn : idClass,
      imgUrlColumn : imgUrl
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, name: $name, idClass : $idClass, img: $imgUrl)";
  }

}