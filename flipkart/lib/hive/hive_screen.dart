import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_first_app/hive/hive_db.dart';
import 'package:my_first_app/hive/todo.dart';


class HiveToDoScreen extends StatefulWidget {
  const HiveToDoScreen({super.key});

  @override
  State<HiveToDoScreen> createState() => _HiveToDoScreenState();
}

class _HiveToDoScreenState extends State<HiveToDoScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveDb.instance.getAll(),
      builder: (context, box, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'TODOs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddTodo(length: box.length),
            ).then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (BuildContext context, int index) {
            final element = box.getAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.amber,
                title: Text(element.title),
                subtitle: Text(element.body),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddTodo(
                            no: index,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 27, 28, 36),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HiveDb.instance.deleteTodo(index);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 255, 17, 0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Add Todo
class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
    this.no,
    this.length,
  });

  final int? no;
  final int? length;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  Todo? data;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.no != null) {
      data = HiveDb.instance.getTodo(widget.no!);
      titleController.text = data!.title;
      bodyController.text = data!.body;
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
            Text('${widget.no == null ? 'Create' : 'Edit'}TODO'),
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
                if (widget.no == null) {
                  HiveDb.instance.createTodo(
                    Todo(
                      // id: widget.length ?? 1,
                      title: titleController.text,
                      body: bodyController.text,
                    ),
                  );
                } else {
                  HiveDb.instance.updateTodo(
                    widget.no!,
                    Todo(
                      // id: widget.no!,
                      title: titleController.text,
                      body: bodyController.text,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
