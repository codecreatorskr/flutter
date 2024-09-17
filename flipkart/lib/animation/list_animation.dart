import 'package:flutter/material.dart';

class AnimationListScreen extends StatefulWidget {
  const AnimationListScreen({super.key});

  @override
  State<AnimationListScreen> createState() => _AnimationListScreenState();
}

class _AnimationListScreenState extends State<AnimationListScreen>
    with TickerProviderStateMixin {
  final listKey = GlobalKey<AnimatedListState>();

  late AnimationController controller;


  int counter = 0;

  List<int> _items = [];

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    super.initState();
    _loadItems();
  }

  final _fetchedItems = [1, 2, 3, 4, 5, 6, 7];

  Future<void> _loadItems() async {
    for (int item in _fetchedItems) {
      // 1) Wait for one second
      await Future.delayed(const Duration(milliseconds: 100));
      // 2) Adding data to actual variable that holds the item.
      _items.add(item);
      // 3) Telling animated list to start animation
      listKey.currentState?.insertItem(_items.length - 1);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          listKey.currentState?.insertItem(
            // 0,
            _items.isEmpty ? 0 : _items.length - 1,
            duration: const Duration(microseconds: 1000),
          );
          _items = [counter++, ..._items];
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation),
              child: Container(
                height: 50,
                color: Colors.blue,
                child: Center(child: Text('  data   ${index + 1}')),
              ),
            ),
            // ScaleTransition(
            //   scale: animation,
            //   child: Container(
            //     height: 50,
            //     color: Colors.blue,
            //     child: Center(child: Text('  data   ${index + 1}')),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
