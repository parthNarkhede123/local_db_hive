import 'package:hive/hive.dart';
import 'package:local_db/features/home/data/models/get_data_response.dart';

part 'todo_hive_model.g.dart'; // Ensure this matches the filename

@HiveType(typeId: 0)
class HiveTodo {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? todo;

  @HiveField(2)
  bool? completed;

  @HiveField(3)
  int? userId;

  HiveTodo({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory HiveTodo.fromJson(Map<String, dynamic> json) => HiveTodo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  factory HiveTodo.fromTodo(Todo todo) {
    return HiveTodo(
      id: todo.id,
      todo: todo.todo,
      completed: todo.completed,
      userId: todo.userId,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}
