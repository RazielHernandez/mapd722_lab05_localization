import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapd722_todo_carlos_hernandez/database/task_database.dart';
import 'package:mapd722_todo_carlos_hernandez/objects/task.dart';
import 'package:mapd722_todo_carlos_hernandez/pages/addTask.dart';
import 'package:mapd722_todo_carlos_hernandez/pages/task_record_widget.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  List<Task> listOfTasks = [
    Task(id: "1", title: "title 1", description: "description", category: "category", isDone: true),
    Task(id: "2", title: "title 2", description: "description", category: "category", isDone: false),
    Task(id: "3", title: "title 3", description: "description", category: "category", isDone: false),
    Task(id: "4", title: "title 4", description: "description", category: "category", isDone: false)
  ];

  /*late taskDatabase handler;
  late List<Task> listOfTasks;

  @override
  void initState() {
    super.initState();
    handler = taskDatabase();
    handler.initializeDB().whenComplete(() async {
      //await this.addUsers();
      listOfTasks = handler.tasks() as List<Task>;
      setState(() {});
    });
  }*/

  void completeTask(String id) {
    setState(() {
      listOfTasks.forEach((element) {
        if(element.id == id){
          element.isDone = !element.isDone;
          var elementTitle = element.title;
          var elementStatus = element.isDone;
          print("Now the element $elementTitle is $elementStatus");
        }
      });
    });
  }

  void saveNewTask(Task newTask) {
    setState(() {
      listOfTasks.add(newTask);
      var size = listOfTasks.length;
      print("Now the array has $size");
    });
    
  }

  void _openAddNewTask({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(  context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => addTask(saveNewTask),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: 
        //task_list_widget (completeTask),
        ListView.builder(
          itemBuilder: (context, index) {
            return TaskRecordWidget(
              listOfTasks[index].id,
              listOfTasks[index].title,
              listOfTasks[index].isDone,
              completeTask
            );
          },
          itemCount: listOfTasks.length,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddNewTask(
          context: context,
          fullscreenDialog: true,
        ),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}