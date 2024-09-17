import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/api_services/firebase_api.dart';
import 'package:my_first_app/providers/user_provider.dart';
import 'package:my_first_app/todo_application/todo_model.dart';
import 'package:my_first_app/utils/utils.dart';
import 'package:provider/provider.dart';

class FireToDoScreen extends StatefulWidget {
  const FireToDoScreen({super.key});

  @override
  State<FireToDoScreen> createState() => _FireToDoScreenState();
}

class _FireToDoScreenState extends State<FireToDoScreen> {
  late UserProvider provider;
  bool isloading = true;
  bool loader = false;
  bool pagination = true;
  int offset = 0;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    getData();
    // log(FirebaseAuth.instance.currentUser.toString());
    super.initState();
  }

  void getData() {
    provider.getFireTodos().then((value) {
      setState(() {
        isloading = false;
      });
    });
    // if (!pagination) return;
    // setState(() {
    //   loader = true;
    // });

    // provider.getTodos().then((value) {
    //   isloading = false;

    //   if (value < 10) pagination = false;

    // loader = false;

    //   offset += 10;

    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    // log(FirebaseAuth.instance.currentUser.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Fire. TODOs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FireAddTodo(no: provider.fireTodos.length),
          ).then((value) => provider.getFireTodos());
        },
        child: const Icon(Icons.add),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Selector<UserProvider, List<TodoModel>>(
              selector: (p0, p1) => p1.fireTodos,
              builder: (context, list, child) {
                return NotificationListener(
                  onNotification: (notification) =>
                      Utils.scrollNotifier(notification, getData),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: list.length + (loader ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) => index ==
                            list.length
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              tileColor: Colors.amber,
                              title: Text(list[index].title),
                              subtitle: Text(list[index].body),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      FirebaseApi.instance.updateTodos();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 27, 28, 36),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FirebaseApi.instance.deleteTodos();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 255, 17, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
    );
  }
}

class FireAddTodo extends StatefulWidget {
  const FireAddTodo({
    super.key,
    required this.no,
    this.model,
  });

  final int no;
  final TodoModel? model;

  @override
  State<FireAddTodo> createState() => _FireAddTodoState();
}

class _FireAddTodoState extends State<FireAddTodo> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      titleController.text = widget.model!.title;
      bodyController.text = widget.model!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${widget.model == null ? 'Create' : 'Edit'}TODO'),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textInputAction: TextInputAction.done,
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseApi.instance
                    .createTodos(TodoModel(
                  id: widget.no,
                  title: titleController.text,
                  body: bodyController.text,
                ))
                    .then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
