import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:fluttertoast/fluttertoast.dart';
import '../models/todo_models.dart';
import '../provider/provider_screen.dart';
import '../provider/theme_provider.dart';

class UpdateTodo extends StatefulWidget {
  final Todo todo;

  UpdateTodo({required this.todo, super.key});

  @override
  _UpdateTodoState createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  late TextEditingController title;
  late TextEditingController content;
  late String status;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.todo.title);
    content = TextEditingController(text: widget.todo.content);
    status = widget.todo.completed ? 'Completed' : 'Active';
    selectedDate = DateTime.parse(widget.todo.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ProviderDB>(context);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDarkTheme = themeProvider.isDarkTheme;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Update Todo"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                          hintText: "Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: content,
                      decoration: const InputDecoration(
                          hintText: "Content",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      value: status,
                      icon: const Icon(Icons.arrow_downward),
                      style: TextStyle(color: isDarkTheme ? Colors.white : Colors.black,fontSize: 18,backgroundColor: Colors.black.withOpacity(0.2)),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      items: <String>['Active', 'Completed']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          status = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text("Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null && pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (title.text.isEmpty || content.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Title and Content cannot be empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          await userProvider
                              .updateTodo(Todo(
                            todoId: widget.todo.todoId,
                            title: title.text,
                            content: content.text,
                            completed: status == 'Completed',
                            dateTime: selectedDate.toIso8601String(),
                          ))
                              .whenComplete(() => Navigator.pop(context));
                          Fluttertoast.showToast(
                            msg: "Data updated successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width * 0.8,
                            MediaQuery.of(context).size.height * 0.05)),
                      ),
                      child: Text(
                        'Update',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
