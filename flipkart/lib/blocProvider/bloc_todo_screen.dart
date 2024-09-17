import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/blocProvider/todo_bloc.dart';
import 'package:my_first_app/todo_application/todo_model.dart';
import 'package:my_first_app/utils/utils.dart';

class BlocTodoScreen extends StatefulWidget {
  const BlocTodoScreen({super.key});

  @override
  State<BlocTodoScreen> createState() => _BlocTodoScreenState();
}

class _BlocTodoScreenState extends State<BlocTodoScreen> {
  late TodoBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<TodoBloc>(context)..add(TodoGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc TODOs'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTodo(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoAddState) {
            log(state.success.toString(), name: 'addstate');
            if (state.success) {
              Navigator.pop(context);
              Utils.showSnack('Todo Added');
            } else {
              Utils.showSnack('Something went wrong');
            }
          }
          if (state is TodoDeleteState) {
            if (state.succcess) {
              Utils.showSnack('Todo Deleted');
            } else {
              Utils.showSnack('Something went wrong');
            }
          }
        },
        builder: (context, state) {
          return state is TodoFetched
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.list.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(state.list[index].title),
                    subtitle: Text(state.list[index].body),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   onPressed: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) =>
                        //           AddTodo(model: state.list[index]),
                        //     );
                        //   },
                        //   icon: const Icon(Icons.edit),
                        // ),
                        IconButton(
                          onPressed: () {
                            bloc.add(TodoDelete(id: state.list[index].id));
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class AddTodo extends StatefulWidget {
  const AddTodo({super.key, this.model});

  final TodoModel? model;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      controller1.text = widget.model!.title;
      controller2.text = widget.model!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${widget.model == null ? 'Create' : 'Edit'} TODO'),
            TextField(
              controller: controller1,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller2,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(
                  TodoAdd(
                    model: TodoModel(
                      title: controller1.text,
                      body: controller2.text,
                    ),
                  ),
                );
              },
              child: const Text('ADD'),
            )
          ],
        ),
      ),
    );
  }
}