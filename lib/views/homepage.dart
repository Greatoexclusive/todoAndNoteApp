import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_demoapp/views/components/no_todo_view.dart';
import 'package:todo_demoapp/views/taskpage.dart';
import 'package:todo_demoapp/widgets/taskcard_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> taskList = [];

  addTask(Map<String, dynamic> task) {
    setState(() {
      taskList.add(task);
    });
  }

  removeTask(Map<String, dynamic> task) {
    setState(() {
      taskList.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "My Todo App",
                          style: GoogleFonts.oleoScriptSwashCaps(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Text(
                        taskList.isEmpty
                            ? "No task"
                            : "${taskList.length} tasks",
                        style: GoogleFonts.oleoScriptSwashCaps(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: taskList.isEmpty
                        ? const NoTodoView()
                        : ListView.builder(
                            itemCount: taskList.length,
                            itemBuilder: ((context, index) => Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TaskPage(
                                                  onSave: (updateTask) {
                                                    // 1.identify the position of the item
                                                    //2.update the item
                                                    taskList[index] =
                                                        updateTask;
                                                    setState(() {});
                                                  },
                                                  description: taskList[index]
                                                      ["description"],
                                                  title: taskList[index]
                                                      ["title"],
                                                  todoList: taskList[index]
                                                      ["todo"],
                                                ),
                                              ));
                                        },
                                        child: TaskCardWidget(
                                          todos: taskList[index]["todo"].length,
                                          title: taskList[index]["title"],
                                          description: taskList[index]
                                              ["description"],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Center(
                                                  child: Icon(
                                                Icons.warning,
                                                size: 50,
                                              )),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "You are about to delete the task '${taskList[index]["title"]}'! \n\nProceed?",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .black, // Background color
                                                      ),
                                                      autofocus: true,
                                                      onPressed: () {
                                                        // removeTask(taskList[index]);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No'),
                                                    ),
                                                    // Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .black, // Background color
                                                      ),
                                                      autofocus: true,
                                                      onPressed: () {
                                                        removeTask(
                                                            taskList[index]);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Yes'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ))),
                  )
                ],
              ),
              Positioned(
                bottom: 5,
                right: 80,
                left: 80,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskPage(
                                  onSave: addTask,
                                  todoList: [],
                                  title: "",
                                  description: "",
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 7),
                            color: Colors.grey.withOpacity(0.9),
                          )
                        ],
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Create A Task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Item {
//   String title;
//   String descripton;
//   Item(this.title, this.descripton);
// }
