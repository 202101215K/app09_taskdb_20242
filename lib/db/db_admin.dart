import 'dart:io';

import 'package:app09_taskdb_20242/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Database? myDatabase;

  //Singleton
  static final DbAdmin db = DbAdmin._();
  DbAdmin._();
  //
  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = await initDatabase(); //;
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        await dbx.execute(
            "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");
      },
    );
  }

  Future<int> insertRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title, description, status) VALUES ('Pagar recibo de luz','sacar dinero e ii al agente de pago','false')");
    return res;
  }

  Future<int> insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TASK",
      {
        "title": "Comprar en la feria",
        "description": "Los sabados en las americas",
        "status": "false",
      },
    );
    return res;
  }

  Future<List<Map<String, dynamic>>> getRawTasks() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.rawQuery("SELECT * FROM TASK");
    return tasks;
  }

  Future<List<TaskModel>> getTasks() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("TASK");
    List<TaskModel> taskModelList =
        tasks.map((e) => TaskModel.MapToModel(e)).toList();
    // tasks.forEach((element) {
    //   TaskModel task = TaskModel.MapToModel(element);
    //   taskModelList.add(TaskModel.MapToModel(element));
    // });
    // print(taskModelList);
    return taskModelList;
  }

  Future<int> updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE TASK SET title = 'Pagar el agua', description = 'en emusap', status = 'true' WHERE id = 4");
    return res;
  }

  Future<int> updateTask() async {
    Database? db = await checkDatabase();
    int res = await db!.update(
      "TASK",
      {
        "title": "Cocinar",
        "description": "menu del dia matasquita",
        "status": "false",
      },
      where: "id = 3",
    );
    return res;
  }

  Future<int> deleteRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete("DELETE FROM TASK WHERE id = 4");
    return res;
  }

  Future<int> deleteTask() async {
    Database? db = await checkDatabase();
    int res = await db!.delete("TASK", where: "id = 5");
    return res;
  }
}