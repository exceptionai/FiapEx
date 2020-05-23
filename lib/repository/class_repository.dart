import 'package:sqflite/sqflite.dart';

import '../models/class_model.dart';
import 'repository.dart';

class ClassRepository extends Repository{

  Future<List> getAllClasses() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM ${Repository.classTable["tableName"]};");
    List<ClassModel> listContact = List();
    for(Map m in listMap){
      listContact.add(ClassModel.fromMap(m));
    }
    return listContact;
  }

}