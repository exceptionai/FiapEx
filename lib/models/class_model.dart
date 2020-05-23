class ClassModel{
  
  int id;
  String name;
  static final classTable = {
    "tableName" : "classes",
    "idColumn" : "idClass",
    "nameColumn" : "name"
  };

  ClassModel();

  ClassModel.fromMap(Map map){
    id = map["${classTable["idColumn"]}"];
    name = map["${classTable["nameColumn"]}"];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      "${classTable["idColumn"]}" : id,
      "${classTable["nameColumn"]}" : name
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, name: $name)";
  }


}