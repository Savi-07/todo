import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'To-Do App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ToDoList(),
//     );
//   }
// }

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  final LocalStorage storage = LocalStorage('todo_app');
  TextEditingController controller = TextEditingController();
  List<String> items = [];

  @override

  void initState() {
    super.initState();
    _loadItems();
  }
  

  void _loadItems() async {
    await storage.ready;
    List<String>? storedItems = storage.getItem('items')?.cast<String>();
    if (storedItems != null) {
      setState(() {
        items = storedItems;
      });
    }
  }

  void _addItem(String item) {
    setState(() {
      items.add(item);
      storage.setItem('items', items);
    });
    controller.clear();
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      storage.setItem('items', items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter a task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _addItem(controller.text);
              }
            },
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteItem(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
