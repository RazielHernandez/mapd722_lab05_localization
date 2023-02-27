import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapd722_todo_carlos_hernandez/objects/task.dart';
import 'package:uuid/uuid.dart';

class editTask extends StatefulWidget {
  Task task;
  editTask(this.task);
  _editTask createState() => _editTask();
}

class _editTask extends State<editTask> {
  

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_task),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                const Text("Task info"),

              ],
            ),
          ),
        ),
      ),  
    );
  }
}