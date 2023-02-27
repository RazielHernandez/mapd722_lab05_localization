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

  /*List<Task> listOfTasks = [
    Task(id: "1", title: "title 1", description: "description", category: "category", isDone: true),
    Task(id: "2", title: "title 2", description: "description", category: "category", isDone: false),
    Task(id: "3", title: "title 3", description: "description", category: "category", isDone: false),
    Task(id: "4", title: "title 4", description: "description", category: "category", isDone: false)
  ];*/

  //late taskDatabase handler;
  late List<Task> listOfTasks;

  bool _isLoading = true;
  
  void _loadData() async {
    final data = await taskDatabase.tasks();
    setState(() {
      listOfTasks = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _updateTask(Task task) async {
    await taskDatabase.updateTask(task);
    _loadData();
  }

  void completeTask(String id) async {
    
    listOfTasks.forEach((element) async {
      if(element.id == id){
        element.isDone = !element.isDone;
        var elementTitle = element.title;
        var elementStatus = element.isDone;
        await _updateTask(element);
        print("Now the element $elementTitle is $elementStatus");
      }
    });
  }

  Future<void> _addTask(Task newTask) async {
    await taskDatabase.saveTask(newTask);
    _loadData();
  }

  void saveNewTask(Task newTask) async {
    await _addTask(newTask);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: 
        _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listOfTasks.isEmpty ? const Center(child:  Text("No Data Available!!!")) :
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