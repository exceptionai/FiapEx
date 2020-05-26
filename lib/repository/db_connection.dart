import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {

  static final studentTable = {
    "tableName" : "students",
    "idColumn" : "rm",
    "nameColumn" : "name",
    "classFkColumn" : "idClass",
    "imgUrlColumn" : "imgUrl"
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
    "doneColumn" : "done",
    "fkClassColumn" : "idClass",
    "fkDisciplineColumn" : "idDiscipline" 
  };

  static final rollRegisterTable = {
    "tableName" : "rollRegisters",
    "idColumn" : "idRollRegister",
    "fkStudentColumn" : "rm",
    "fkRollColumn" : "idRoll",
    "presenceColumn" : "presence",
    "registerDateColumn" :"registerDate"
  };

  DbConnection();
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
  
  static Future _onConfigure (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "fiapEx.db");

    List<String> createQueryes = [
      """CREATE TABLE ${classTable["tableName"]}(
          ${classTable["idColumn"]} INTEGER PRIMARY KEY,
          ${classTable["nameColumn"]} TEXT);""",
      """CREATE TABLE ${disciplineTable["tableName"]}(
          ${disciplineTable["idColumn"]} INTEGER PRIMARY KEY,
          ${disciplineTable["nameColumn"]} TEXT);""",
      """CREATE TABLE ${classDisciplineTable["tableName"]}(  
         ${classDisciplineTable["fkClassColumn"]} INTEGER,
         ${classDisciplineTable["fkDisciplineColumn"]} INTEGER,
         ${classDisciplineTable["beginHourColumn"]} TEXT,
         ${classDisciplineTable["endHourColumn"]} TEXT,
         ${classDisciplineTable["dayColumn"]} INTEGER,
         FOREIGN KEY(${classDisciplineTable["fkClassColumn"]}) references ${classTable["tableName"]} (${classTable["idColumn"]}),
         FOREIGN KEY(${classDisciplineTable["fkDisciplineColumn"]}) references ${disciplineTable["tableName"]} (${disciplineTable["idColumn"]}));""",
      """CREATE TABLE ${studentTable["tableName"]}(
         ${studentTable["idColumn"]} INTEGER PRIMARY KEY,
         ${studentTable["nameColumn"]} TEXT,
         ${studentTable["classFkColumn"]} INTEGER,
         ${studentTable["imgUrlColumn"]} TEXT,
         FOREIGN KEY (${studentTable["classFkColumn"]}) references ${classTable["tableName"]} (${classTable["idColumn"]}));""",
      """CREATE TABLE ${rollTable["tableName"]}(
         ${rollTable["idColumn"]} INTEGER PRIMARY KEY,
         ${rollTable["dateColumn"]} TEXT,
         ${rollTable["doneColumn"]} TEXT,
         ${rollTable["fkClassColumn"]} INTEGER,
         ${rollTable["fkDisciplineColumn"]} INTEGER,
         FOREIGN KEY (${rollTable["fkClassColumn"]}) references ${classTable["tableName"]} (${classTable["idColumn"]}),
         FOREIGN KEY (${rollTable["fkDisciplineColumn"]}) references ${classTable["tableName"]} (${classTable["idColumn"]}));""",
      """CREATE TABLE ${rollRegisterTable["tableName"]}(
         ${rollRegisterTable["idColumn"]} INTEGER PRIMARY KEY,
         ${rollRegisterTable["fkStudentColumn"]} INTEGER,
         ${rollRegisterTable["fkRollColumn"]} INTEGER,
         ${rollRegisterTable["presenceColumn"]} TEXT,
         ${rollRegisterTable["registerDateColumn"]} TEXT,
         FOREIGN KEY (${rollRegisterTable["fkStudentColumn"]}) references ${studentTable["tableName"]} (${studentTable["idColumn"]}),
         FOREIGN KEY (${rollRegisterTable["fkRollColumn"]}) references ${rollTable["tableName"]} (${rollTable["idColumn"]}));""",
    ];

    List<String> inserts = [
      """INSERT INTO ${classTable["tableName"]} (${classTable["idColumn"]},
        ${classTable["nameColumn"]}) VALUES (1,'3SIT');""",
      """INSERT INTO ${classTable["tableName"]} (${classTable["idColumn"]},
        ${classTable["nameColumn"]}) VALUES (2,'3SIR');""",
      """INSERT INTO ${disciplineTable["tableName"]} (${disciplineTable["idColumn"]},
        ${disciplineTable["nameColumn"]}) VALUES (1,'Desenvolvimento Cross Platafform');""",
      """INSERT INTO ${disciplineTable["tableName"]} (${disciplineTable["idColumn"]},
        ${disciplineTable["nameColumn"]}) VALUES (2,'Microservice and Web engineering');""",
      """INSERT INTO ${disciplineTable["tableName"]} (${disciplineTable["idColumn"]},
        ${disciplineTable["nameColumn"]}) VALUES (3,'Operation System Tunning and Cognation');""",  
      """INSERT INTO ${classDisciplineTable["tableName"]} (${classDisciplineTable["fkClassColumn"]},
        ${classDisciplineTable["fkDisciplineColumn"]},
        ${classDisciplineTable["beginHourColumn"]},
        ${classDisciplineTable["endHourColumn"]},
        ${classDisciplineTable["dayColumn"]}) VALUES (1,1,'21:15','22:55',2);""",
      """INSERT INTO ${classDisciplineTable["tableName"]} (${classDisciplineTable["fkClassColumn"]},
        ${classDisciplineTable["fkDisciplineColumn"]},
        ${classDisciplineTable["beginHourColumn"]},
        ${classDisciplineTable["endHourColumn"]},
        ${classDisciplineTable["dayColumn"]}) VALUES (2,1,'07:15','12:15',1);""",
      """INSERT INTO ${classDisciplineTable["tableName"]} (${classDisciplineTable["fkClassColumn"]},
        ${classDisciplineTable["fkDisciplineColumn"]},
        ${classDisciplineTable["beginHourColumn"]},
        ${classDisciplineTable["endHourColumn"]},
        ${classDisciplineTable["dayColumn"]}) VALUES (1,2,'19:20','21:00',5);""",
      """INSERT INTO ${classDisciplineTable["tableName"]} (${classDisciplineTable["fkClassColumn"]},
        ${classDisciplineTable["fkDisciplineColumn"]},
        ${classDisciplineTable["beginHourColumn"]},
        ${classDisciplineTable["endHourColumn"]},
        ${classDisciplineTable["dayColumn"]}) VALUES (2,3,'07:15','12:15',3);""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (1,'Bambam',1,'bambam.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (2,'Bob Esponja',2,'bob-esponja.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (3,'Capitã marvel',1,'capita-marvel.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (4,'Carlos Alberto',2,'carlos-alberto.jpg');""",  
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (5,'Celso Portiolli',1,'celso-portiolli.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (6,'Doutor Manhatam',2,'doutor-manhatam.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (7,'Faustinho Silva',1,'faustinho-silva.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (8,'Hello Kitty',2,'hello-kit.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (9,'Homem Aranha',1,'homem-aranha.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (10,'Hulk',2,'hulk.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (11,'Piano Cat',1,'piano-cat.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (12,'Robert Pattinson',2,'robert-pattinson.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (13,'Sherek',1,'sherek.png');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (14,'Steve Jobs',2,'steve-jobs.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (15,'Susana Vieira',1,'susana-vieira.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (16,'Tony Ramos',2,'tony-ramos.jpg');""",
      """INSERT INTO  ${studentTable["tableName"]} (
         ${studentTable["idColumn"]},
         ${studentTable["nameColumn"]},
         ${studentTable["classFkColumn"]},
         ${studentTable["imgUrlColumn"]}) VALUES (17,'Toninho Estrela',1,'tony-stark.jpg');""",
    ];
    
    return await openDatabase(path, version: 1, onConfigure: _onConfigure, onCreate: (Database db, int newerVersion) async {
      
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