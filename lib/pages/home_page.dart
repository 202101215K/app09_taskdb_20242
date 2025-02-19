import 'package:app09_taskdb_20242/db/db_admin.dart';
import 'package:app09_taskdb_20242/task_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // DbAdmin.db.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text("TaskDb App"),
      ),
      body: FutureBuilder(
        future: DbAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<TaskModel> myTask = snap.data;
            return ListView.builder(
              itemCount: myTask.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(myTask[index].title),
                  subtitle: Text(myTask[index].description),
                  leading: Text(myTask[index].id.toString()),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}