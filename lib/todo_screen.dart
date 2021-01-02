import 'package:flutter/material.dart';
import 'package:todo_example3/addTask_screen.dart';
import 'package:todo_example3/task.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // int stateControl = 0;
  List<Task> taskList = [
    Task(taskName: "asd", toDone: true, editMode: false),
    Task(taskName: "df", toDone: true, editMode: true),
    Task(taskName: "fdg", toDone: false, editMode: false),
    // Task(taskName: "asd", toDone: false, editMode: false),
    // Task(taskName: "fdv", toDone: true, editMode: false),
    // Task(taskName: "asd", toDone: true, editMode: true),
    // Task(taskName: "dfv", toDone: true, editMode: true),
    // Task(taskName: "asd", toDone: false, editMode: false),
    // Task(taskName: "asd", toDone: false, editMode: false),
    // Task(taskName: "gb", toDone: true, editMode: false),
    // Task(taskName: "asd", toDone: true, editMode: false),
    // Task(taskName: "dvvfvfvfvfvfvvfvf", toDone: true, editMode: true),
    // Task(taskName: "asd", toDone: false, editMode: false),
  ];
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    taskList.forEach((element) {
      if (element.toDone == true) {
        setState(() {
          counter++;
        });
      }
      // print("$counter");
    });
    return Scaffold(
      appBar: AppBar(title: Text("ToDo List")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          //  color: Colors.white,
        ),
        onPressed: () async {
          String newTaskName = await showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddTaskScreen(
                    // addTask: (newTask) {
                    //   setState(() {
                    //     taskList.add(Task(
                    //         taskName: newTask, toDone: false, editMode: false));
                    //     // print(newTask);
                    //   });
                    //   Navigator.pop(context, );
                    // },
                    );
              });

          setState(() {
            taskList.add(
                Task(taskName: newTaskName, editMode: false, toDone: false));
          });
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //  color: Colors.purple,
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: TopArea(
              taskLength: taskList.length,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          taskList.removeAt(index);
                        });
                      },
                      child: TaskListTile(
                        item: taskList[index],
                        changeCeckbox: (bool val) {
                          setState(() {
                            taskList[index].toDone = val;
                          });
                        },
                        onEditMode: (bool val) {
                          setState(() {
                            taskList[index].editMode = val;
                          });
                        },
                        onSaveMode: (String newText) {
                          setState(() {
                            taskList[index].taskName = newText;
                            taskList[index].editMode = false;
                          });
                        },
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class TopArea extends StatelessWidget {
  final int taskLength;
  const TopArea({
    Key key,
    this.taskLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$taskLength Total Task"),
            //  Text("$counter Done Task"),
          ],
        )
      ],
    );
  }
}

class TaskListTile extends StatefulWidget {
  final Task item;
  final Function changeCeckbox;
  final Function onEditMode;
  final Function onSaveMode;

  const TaskListTile({
    Key key,
    this.item,
    this.changeCeckbox,
    this.onSaveMode,
    this.onEditMode,
  }) : super(key: key);

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  void initState() {
    super.initState();
    textController.text = widget.item.taskName;
  }

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: widget.item.editMode
            ? TextField(
                controller: textController,
              )
            : Text("${widget.item.taskName}"),
        trailing: Checkbox(
            value: widget.item.toDone, onChanged: widget.changeCeckbox),
        leading: widget.item.editMode
            ? IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  widget.onSaveMode(textController.text);
                })
            : IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  widget.onEditMode(true);
                }));
  }
}
