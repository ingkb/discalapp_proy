import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'amor.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE students(id INT PRIMARY KEY, user varchar(255), password varchar(255));
        CREATE TABLE teachers(id INT PRIMARY KEY, user varchar(255), password varchar(255));
        ''');
    }, version: 1);
  }

  newStudent(Student student) async {
    final db = await database;

    db.rawDelete('''
    DELETE FROM students
    ''');
    db.rawInsert('''
    INSERT INTO students(id, user,password) VALUES (?,?,?)
    ''', [1, student.userId, student.password]);
  }

  modifyStudent(Student student) async {
    final db = await database;

    var res = await db.rawUpdate('''
    UPDATE students SET user = ?, password = ? WHERE id=1
    ''', [student.userId, student.password]);
    return res;
  }

  Future<Student> getStudent() async {
    final db = await database;
    var res = await db.query("students");
    var student = Student();
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];

      if (resMap != null && resMap.isNotEmpty) {
        student = new Student(
            userId: resMap['user'],
            password: resMap['password'],
            );
        return student;
      } else {
        return null;
      }
    }
  }

 // ------------------- Teacher metodos ------------------//
  newTeacher(Teacher teacher) async {
    final db = await database;

    db.rawDelete('''
    DELETE FROM teachers
    ''');
    db.rawInsert('''
    INSERT INTO teachers(id, user,password) VALUES (?,?,?)
    ''', [1, teacher.userId, teacher.password]);
  }

  modifyTeacher(Teacher teacher) async {
    final db = await database;

    var res = await db.rawUpdate('''
    UPDATE teachers SET user = ?, password = ? WHERE id=1
    ''', [teacher.userId, teacher.password]);
    return res;
  }

  Future<Teacher> getTeacher() async {
    final db = await database;
    var res = await db.query("teachers");
    var teacher = Teacher();
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];

      if (resMap != null && resMap.isNotEmpty) {
        teacher = new Teacher(
            id: resMap['id'],
            userId: resMap['user'],
            password: resMap['password'],
            );
        return teacher;
      } else {
        return null;
      }
    }
  }
}
