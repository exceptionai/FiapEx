import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/class_repository.dart';
import 'package:FiapEx/repository/discipline_repository.dart';
import 'package:FiapEx/repository/rollRegister_repository.dart';
import 'package:FiapEx/repository/roll_repository.dart';
import 'package:FiapEx/repository/student_repository.dart';
import 'package:flutter/material.dart';

class RowCallService{
  RollRepository repository = new RollRepository();
  ClassRepository classRepository = new ClassRepository();
  DisciplineRepository disciplineRepository = new DisciplineRepository();
  StudentRepository studentRepository = new StudentRepository();
  RollRegisterRepository rollRegisterRepository = new RollRegisterRepository();

  Future<List<RollModel>> getAllRowCall() async{
    List<RollModel> rows = await repository.getAllRolles();
    for(RollModel row in rows){
      ClassModel classRow = await classRepository.getClass(row.idClass);
      DisciplineModel disciplineRow = await disciplineRepository.getDiscipline(row.idDiscipline);
      List<StudentModel> students = await studentRepository.getAllStudentsByClass(row.idClass);
      int presentStudents = await rollRegisterRepository.presenceStudentsCount(rowCallId: row.id, presence: 1);
      int absentStudents = await rollRegisterRepository.presenceStudentsCount(rowCallId: row.id, presence: 0);

      row.students = students;
      row.presentStudents = presentStudents;
      row.absentStudents = absentStudents;
      row.studentClass = classRow;
      row.discipline = disciplineRow;   
    }
    return rows;
  }

  Future<List<ClassModel>> getAllClasses() async{
    return await classRepository.getAllClasses();
  }

  Future<List<DisciplineModel>> getAllDisciplinesByClass({int classId}) async{
    return await disciplineRepository.getAllDisciplinesByClass(classId: classId);
  }

  Future<bool> finishRowCall({int rowCallId, DateTime date}) async{
    int updatedId = await repository.finishRowCall(rowCallId:rowCallId, date: date.toIso8601String());
    if(updatedId != null){
      return true;
    }
    return false;
  }

  Future<bool> setPresence(bool presence, {int studentId, int rowCallId}) async{
    bool successful = await rollRegisterRepository.saveRollRegister(rowCallId, studentId, presence);
    return successful;
  }

  Future<List<int>> getPresentStudents({@required int rowCallId, int studentId}) async{
    return await rollRegisterRepository.getPresenceStudent(1, rowCallId: rowCallId);
  }

  Future<List<int>> getAbsentStudents({@required int rowCallId, int studentId}) async{
    return await rollRegisterRepository.getPresenceStudent(0, rowCallId: rowCallId);
  }

  Future<RollModel> createRowCall(RollModel rowCallModel) async{
     ClassModel classRow = await classRepository.getClass(rowCallModel.idClass);
     DisciplineModel disciplineRow = await disciplineRepository.getDiscipline(rowCallModel.idDiscipline);
    List<StudentModel> students = await studentRepository.getAllStudentsByClass(rowCallModel.idClass);

    rowCallModel.students = students;
    rowCallModel.presentStudents = 0;
    rowCallModel.absentStudents = 0;
    rowCallModel.studentClass = classRow;
    rowCallModel.discipline = disciplineRow;   
    RollModel model = await repository.saveRoll(rowCallModel);
    return model;
  }
}