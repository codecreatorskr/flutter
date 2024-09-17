import 'package:hive_flutter/hive_flutter.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  // @HiveField(0)
  // final int id;

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;

  Todo( {
    // required this.id,
    required this.title,
    required this.body,
  });
}
