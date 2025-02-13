import 'package:app09_taskdb_20242/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TaskDb App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.initDatabase();
              },
              child: Text("Creando Base de Datos"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.insertTask();
              },
              child: Text("Insert task"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.getTasks();
              },
              child: Text("Get tasks"),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.updateRawTask();
              },
              child: Text("Update task"),
            ),
          ],
        ),
      ),
    );
  }
}