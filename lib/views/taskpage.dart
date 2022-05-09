import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_demoapp/widgets/todo_widget.dart';

class TaskPage extends StatefulWidget {
  TaskPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.todoList,
      required this.onSave})
      : super(key: key);
  String title;
  String description;
  List<Map<String, dynamic>> todoList;
  Function(Map<String, dynamic>) onSave;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // List<String> todoList = ["Todo 1", "todo 2"];
  var todoController = TextEditingController();
  var titleController = TextEditingController();
  var desController = TextEditingController();

  final Map<String, dynamic> taskList = {};

  @override
  void initState() {
    titleController.text = widget.title;
    desController.text = widget.description;
    setState(() {});
    super.initState();
  }

  addValue() {
    setState(() {
      widget.todoList.add(
        {"text": todoController.text, "isCompleted": false},
      );
    });
    print(widget.todoList);
  }

  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // setState(() {});

                            taskList["title"] = titleController.text;
                            taskList["description"] = desController.text;
                            taskList["todo"] = widget.todoList;
                            setState(() {
                              widget.onSave(taskList);
                            });

                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            onSubmitted: (value) {
                              print(value);
                            },
                            maxLines: 1,
                            cursorColor: Colors.black,
                            style: GoogleFonts.eczar(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Task Title",
                                hintStyle: TextStyle(fontSize: 30)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        // height: 90,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 2,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: desController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.prozaLibre(
                              fontSize: 20, fontWeight: FontWeight.w200),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.todoList.length,
                        itemBuilder: ((context, index) => InkWell(
                              onTap: () {
                                print(widget.todoList[index]["isCompleted"]
                                    .toString());

                                widget.todoList[index]["isCompleted"] =
                                    !widget.todoList[index]["isCompleted"];

                                setState(() {});
                              },
                              child: TodoWidget(
                                text: widget.todoList[index]["text"],
                                isCompleted: widget.todoList[index]
                                    ["isCompleted"],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 5,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      // setState(() {});
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(child: Text('Enter a Todo')),
                          content: TextField(
                            controller: todoController,
                            cursorColor: Colors.black,
                            style: GoogleFonts.prozaLibre(
                                fontSize: 20, fontWeight: FontWeight.w200),
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "My todo",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black, // Background color
                                ),
                                onPressed: () {
                                  if (todoController.text.isNotEmpty) {
                                    addValue();
                                  }
                                  Navigator.pop(context);
                                  todoController.clear();
                                },
                                child: Text('Add...'))
                          ],
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 7),
                              color: Colors.grey.withOpacity(0.9),
                            )
                          ],
                          color: Colors.black,
                          border: Border.all(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "New Todo",
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
      ),
    );
  }
}
