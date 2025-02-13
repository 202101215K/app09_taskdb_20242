import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  //base de datos al principio saldra error por que no existe
  Database? myDatabase;
 //Singleton
 static final DbAdmin db = DbAdmin._();
  DbAdmin._();
  //Metodo para verificar la existencia de la base de datos 
 Future<Database?> checkDatabase()async{
    if (myDatabase != null) {
       return myDatabase;
    }
    myDatabase = await initDatabase();
    return myDatabase; 
  }
  //inicializando la base de datos o creacion de la base de datos
  Future<Database> initDatabase()async{
    //Derictorio de la base de datos donde se va guardar
    Directory directory = await getApplicationDocumentsDirectory();
    //Creando la base de datos
    String path = join(directory.path,"TaskDB.db");
    //Abriendo la base de datos
   return await openDatabase(path,
    version: 1,
    onOpen: (db) {},
    //Creacion de la tabla de la base de datos
    onCreate: (Database dbx, int version) async{
     await dbx.execute(
         "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)"
      );
    },
    );

  }
  insertRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title, description, status) VALUES ('Pagar recibo de luz','sacar dinero e ii al agente de pago','false')");
  }

  insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TASK",
      {
        "title": "Comprar en la feria",
        "description": "Los sabados en las americas",
        "status": "false",
      },
    );
  }

  getRawTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM TASK");
    print(tasks);
  }

  getTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.query("TASK");
    print(tasks);
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE TASK SET title = 'Pagar el agua', description = 'en emusap', status = 'true' WHERE id = 4");
    print(res);
  }
}