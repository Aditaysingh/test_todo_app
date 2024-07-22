import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/todo_models.dart';
import '../provider/provider_screen.dart';
import '../provider/theme_provider.dart';
import '../theme/theme.dart';
import 'add_screen.dart';
import 'update_screens.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProviderDB, ThemeProvider>(
      builder: (context, providerDB, themeProvider, child) {
        bool isDarkTheme = themeProvider.isDarkTheme;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddTodo()));
            },
            child: Icon(Icons.add, color: Colors.black),
          ),
          appBar: AppBar(
            title: const Text("Todo"),
            actions: [
              IconButton(
                icon: Icon(isDarkTheme ? Icons.dark_mode_sharp : Icons.light_mode_outlined),
                onPressed: () {
                  themeProvider.toggleTheme(!isDarkTheme);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Filter:- "),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: providerDB.currentFilter,
                      icon: const Icon(Icons.filter_list),
                      underline: Container(),
                      onChanged: (String? newValue){
                        if (newValue != null) {
                          providerDB.setFilter(newValue);
                        }
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.black : Colors.white,
                        backgroundColor: isDarkTheme ? Colors.grey[500]?.withOpacity(0.5) : Colors.white,

                      ),
                      items: <String>['All', 'Completed', 'Active']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: isDarkTheme ? Colors.white : Colors.black,
                              backgroundColor: isDarkTheme ? Colors.grey[500]?.withOpacity(0.5) : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: providerDB.filteredTodos.isEmpty
                    ? Center(
                  child: Text(providerDB.currentFilter == 'Active'
                      ? "No Active Data"
                      : providerDB.currentFilter == 'Completed'
                      ? "No Completed Data"
                      : "No Todo"),
                )
                    : ListView.builder(
                  itemCount: providerDB.filteredTodos.length,
                  itemBuilder: (context, index) {
                    Todo todo = providerDB.filteredTodos[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: isDarkTheme
                          ? darkContainerDecoration
                          : lightContainerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                todo.completed ? 'Completed' : 'Active',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: todo.completed
                                      ? Colors.red.withOpacity(0.5)
                                      : Colors.green.withOpacity(0.5),
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  if (value == 'Update') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateTodo(
                                          todo: todo,
                                        ),
                                      ),
                                    );
                                  } else if (value == 'Delete') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Confirm Delete"),
                                          content: Text(
                                              "Are you sure you want to delete this item?"),
                                          actions: [
                                            TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Delete"),
                                              onPressed: () {
                                                providerDB.deleteTodo(
                                                    todo.todoId!);
                                                Navigator.of(context)
                                                    .pop();
                                                Fluttertoast.showToast(
                                                  msg: "${todo.completed ? 'Completed' : 'Active'} data deleted successfully",
                                                  toastLength:
                                                  Toast.LENGTH_SHORT,
                                                  gravity:
                                                  ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                  Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                itemBuilder:
                                    (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Update',
                                    child: Text('Update'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Name :-      ${todo.title}", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Content :-    ${todo.content}"),
                          Text(
                              "Status :-      ${todo.completed ? 'Completed' : 'Active'}"),
                          Text(
                            "DateTime :-  ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(todo.dateTime))}",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

