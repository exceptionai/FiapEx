import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Repository {

  static final studentTable = {
    "tableName" : "students",
    "idColumn" : "rm",
    "nameColumn" : "name",
    "birthDateColumn" : "birthDate",
    "classFkColumn" : "idClass"
  };

  static final classTable = {
    "tableName" : "classes",
    "idColumn" : "idClass",
    "nameColumn" : "name"
  };

  static final disciplineTable = {
    "tableName" : "disciplines",
    "idColumn" : "idDiscipline",
    "nameColumn" : "name"
  };

  static final classDisciplineTable = {
    "tableName" : "classDiscipline",
    "fkClassColumn" : "idClass",
    "fkDisciplineColumn" : "idDiscipline",
    "beginHourColumn" : "beginHour",
    "endHourColumn" : "endHour",
    "dayColumn" : "day"
  };

  static final rollTable = {
    "tableName" : "rolls",
    "idColumn" : "idRoll",
    "dateColumn" : "date",
    "DoneColumn" : "done",
    "fkClassColumn" : "idClass",
    "fkDisciplineColumn" : "idDiscipline" 
  };

  static final rollRegisterTable = {
    "tableName" : "rollRegisters",
    "idColumn" : "idrollRegister",
    "fkStudentColumn" : "idStudent",
    "fkRollColumn" : "idRoll",
    "PresenceColumn" : "presence"
  };

  Repository();
  /*static final Repository _instance = Repository.internal();

  factory Repository() => _instance;

  Repository.internal();*/

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    List<String> createQueryes = [
      "CREATE TABLE ${classTable["tableName"]}("
          "${classTable["idColumn"]} INTEGER PRIMARY KEY,"
          "${classTable["nameColumn"]} TEXT;",
      "CREATE TABLE ${disciplineTable["tableName"]}("
        "${disciplineTable["idColumn"]} INTEGER PRIMARY KEY,"
        "${disciplineTable["nameColumn"]} TEXT;",
      "CREATE TABLE ${classDisciplineTable["tableName"]}("  
        "${classDisciplineTable["fkClassColumn"]} INTEGER,"
        "${classDisciplineTable["fkDisciplineColumn"]} INTEGER,"
        "${classDisciplineTable["beginHourColumn"]} TEXT,"
        "${classDisciplineTable["endHourColumn"]} TEXT,"
        "${classDisciplineTable["dayColumn"]} INTEGER,"
        "FOREIGN KEY(${classDisciplineTable["fkClassColumn"]}) references (${classTable["tableName"]}),"
        "FOREIGN KEY(${classDisciplineTable["fkDisciplineColumn"]}) references (${disciplineTable["tableName"]}));",
      "CREATE TABLE ${studentTable["tableName"]}(,"
        "${studentTable["idColumn"]} INTEGER PRIMARY KEY,"
        "${studentTable["nameColumn"]} TEXT,"
        "${studentTable["birthDateColumn"]} TEXT,"
        "${studentTable["classFkColumn"]} INTEGER,"
        "FOREIGN KEY (${studentTable["classFkColumn"]}) references (${classTable["tableName"]}));",
      "CREATE TABLE ${rollTable["tableName"]}("
        "${rollTable["idColumn"]} INTEGER PRIMARY KEY," 
        "${rollTable["dateColumn"]} TEXT,"
        "${rollTable["DoneColumn"]} TEXT,"
        "${rollTable["fkClassColumn"]} INTEGER,"
        "${rollTable["fkDisciplineColumn"]} INTEGER,"
        "FOREIGN KEY (${rollTable["fkClassColumn"]}) references (${classTable["tableName"]}),"
        "FOREIGN KEY (${rollTable["fkDisciplineColumn"]}) references (${classTable["tableName"]}));",
      "CREATE TABLE ${rollRegisterTable["tableName"]}("
        "${rollRegisterTable["idColumn"]} INTEGER PRIMARY KEY," 
        "${rollRegisterTable["fkStudentColumn"]} INTEGER,"
        "${rollTable["fkRollColumn"]} INTEGER,"
        "${rollTable["presence"]} TEXT,"
        "FOREIGN KEY (${rollTable["fkStudentColumn"]}) references (${studentTable["tableName"]}),"
        "FOREIGN KEY (${rollTable["fkRollColumn"]}) references (${rollTable["tableName"]}));",
    ];

    List<String> inserts = [
      "INSERT INTO ${classTable["tableName"]} (${classTable["idColumn"]},"
        "${classTable["nameColumn"]}) VALUES (1,'3SIT');",
      "INSERT INTO ${disciplineTable["tableName"]} (${disciplineTable["idColumn"]},"
        "${disciplineTable["nameColumn"]}) VALUES (1,'flutter');", 
      "INSERT INTO ${classDisciplineTable["tableName"]} (${classDisciplineTable["fkClassColumn"]},"
        "${classDisciplineTable["fkDisciplineColumn"]},"
        "${classDisciplineTable["beginHourColumn"]},"
        "${classDisciplineTable["endHourColumn"]},"
        "${classDisciplineTable["dayColumn"]}) VALUES (1,1,'21:15','22:55',2);"
    ];
      
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      
      for (String create in createQueryes){
        await db.execute(create);
      }
      for (String insert in inserts){
        await db.execute(insert);
      }
      
    });
  }
}

  /*Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
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

class Contact {

  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact();

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
  
}*/