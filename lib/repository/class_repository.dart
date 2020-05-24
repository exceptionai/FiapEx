import 'package:FiapEx/repository/db_conection.dart';
import 'package:FiapEx/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

import '../models/class_model.dart';
import 'repository.dart';

class ClassRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = DbConnection.classTable["tableName"];
  final String idColumn = DbConnection.classTable["tableName"];

  Future<List> getAllClasses() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table;");
    List<ClassModel> listContact = List();
    for(Map m in listMap){
      listContact.add(ClassModel.fromMap(m));
    }
    return listContact;
  }

  Future<ClassModel> saveClass(ClassModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<ClassModel> getClass(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for(Map m in listMap){
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }


}