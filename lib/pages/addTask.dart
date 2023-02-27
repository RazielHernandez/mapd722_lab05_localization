import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapd722_todo_carlos_hernandez/objects/task.dart';
import 'package:uuid/uuid.dart';

class addTask extends StatefulWidget {

  final void Function(Task) onSaveTask;
  addTask(this.onSaveTask);

  @override
  _addTask createState() => _addTask();
}


class _addTask extends State<addTask>{

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  Task task = Task(id: const Uuid().v1(), title: "", description: "", category: "", isDone: false);

  String? _validateTaskName(String value) {
    if (value.isEmpty){
      return AppLocalizations.of(context)!.error_validate_taskname;
    }
    return null;
  }

  saveTask() {
    print("on save task");
    if(_formStateKey.currentState!.validate()) {
      _formStateKey.currentState?.save();
      var temporlaName = task.title;
      print("task name is: $temporlaName");
    }else{
      print("some error");
    }
  }

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
                Form(
                  key: _formStateKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Task name',
                            labelText: AppLocalizations.of(context)!.taskname,
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) => _validateTaskName(value!),
                          //onSaved: (value) => _task.title = value!,
                          onSaved: ((value) {
                            print("object");
                            task.title = value!;
                          }),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                            hintText: 'Task description',
                            labelText: AppLocalizations.of(context)!.taskdescription,
                            
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (value) => task.description = value!,
                        ),
                        const Divider(height: 32.0,),
                        ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.buttonsavelabel),
                          //color: Colors.lightGreen,
                          onPressed: () {
                            setState(() {
                              saveTask();
                              //onSaveTask(task);
                              widget.onSaveTask(task);
                              Navigator.pop(context);
                            });
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),  
    );
  }
}