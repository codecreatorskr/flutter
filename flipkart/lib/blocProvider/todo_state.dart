part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoFetched extends TodoState {
  final List<TodoModel> list;

  TodoFetched({required this.list});
}

class TodoInit extends TodoState {}

class TodoAddState extends TodoState {
  final bool success;

  TodoAddState({required this.success});
}

class TodoDeleteState extends TodoState {
  final bool succcess;

  TodoDeleteState({required this.succcess});
}
