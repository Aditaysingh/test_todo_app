class Todo {
  final int? todoId;
  final String title;
  final String content;
  bool completed;
  final String dateTime;

  Todo({
    this.todoId,
    required this.title,
    required this.content,
    required this.completed,
    required this.dateTime,
  });

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    todoId: json["todoId"],
    title: json["title"],
    content: json["content"],
    completed: json["completed"] == 1,
    dateTime: json['dateTime'],
  );

  Map<String, dynamic> toMap() => {
    "todoId": todoId,
    "title": title,
    "content": content,
    "completed": completed ? 1 : 0,
    "dateTime": dateTime,
  };
}
