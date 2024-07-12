import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ToDo/widgets/ToDoItems.dart'; // Check if this import path is correct

class todohome extends StatefulWidget {
  const todohome({super.key});

  @override
  State<todohome> createState() => _todohomeState();
}

class _todohomeState extends State<todohome> {
  TextEditingController addcontroller = TextEditingController();
  LocalStorage storage = LocalStorage("todoapp");
  String searchquery = "";

  List<String> tasks = [];
  List<String> filteredtask = []; // Ensure this is initialized properly

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    await storage.ready;
    List<String>? storedItems = storage.getItem('tasks')?.cast<String>();
    if (storedItems != null) {
      setState(() {
        tasks = storedItems;
        filteredtask = List.from(tasks); // Initialize filteredtask correctly
      });
    }
  }

  void deletetask(int index) {
    setState(() {
      tasks.removeAt(index);
      storage.setItem("tasks", tasks);
      _updateFilteredTasks(); // Update filtered tasks after deletion
    });
  }

  void additems(String controller) {
    setState(() {
      tasks.add(controller);
      storage.setItem('tasks', tasks);
      _updateFilteredTasks(); // Update filtered tasks after addition
    });
    addcontroller.clear();
  }

  void _updateFilteredTasks() {
    setState(() {
      filteredtask = tasks
          .where(
              (task) => task.toLowerCase().contains(searchquery.toLowerCase()))
          .toList();
    });
  }

  void dialogbox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a new ToDO"),
          content: TextField(
            controller: addcontroller,
            decoration: InputDecoration(hintText: "Enter your todo"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (addcontroller.text.isNotEmpty) {
                  additems(addcontroller.text);
                }
                Navigator.pop(context);
              },
              child: Icon(Icons.save),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogbox();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: _buildappbar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchbox(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Text(
                "All ToDos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredtask.length,
                itemBuilder: (context, index) {
                  return Todoitems(
                    text: filteredtask[index],
                    onDelete: () {
                      deletetask(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchquery = value;
                _updateFilteredTasks(); // Update filtered tasks on search
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIconConstraints:
                  BoxConstraints(minWidth: 25, maxHeight: 20),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildappbar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('asset/profile.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
