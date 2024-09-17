import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/api_services/firebase_api.dart';
import 'package:my_first_app/todo_application/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInit()) {
    on((event, emit) async {
      if (event is TodoGet) {
        await FirebaseApi.instance.getTodos().then((value) {
          List<TodoModel> tempData = List.from(
            value.map(
                (e) => TodoModel.fromJson(e.data() as Map<String, dynamic>)),
          );
          emit(TodoFetched(list: tempData));
        });
      } else if (event is TodoAdd) {
        await FirebaseApi.instance.createTodo(event.model).then((value) {
          emit(TodoAddState(success: value));
          add(TodoGet());
        });
        add(TodoGet());
      } else if (event is TodoDelete) {
        await FirebaseApi.instance.deleteTodo(event.id).then((value) {
          emit(TodoDeleteState(succcess: true));
          add(TodoGet());
        });
      }
    });
  }
}
