import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txt1 = TextEditingController();

  List<String> mylist = [];
  int? editingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App"),
        backgroundColor: Colors.pinkAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            /// TextField
            TextField(
              controller: txt1,
              decoration: InputDecoration(
                hintText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            /// Add Button
            ElevatedButton(
              onPressed: addTask,
              child: Text("Add Task"),
            ),

            SizedBox(height: 10),

            /// Update Button
            ElevatedButton(
              onPressed: updateTask,
              child: Text("Update Task"),
            ),

            SizedBox(height: 10),

            /// Task List
            Expanded(
              child: ListView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),

                      title: Text(mylist[index]),

                      subtitle: Text("Task Item"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          /// Edit Button
                          IconButton(
                            onPressed: () {
                              editTask(index);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),

                          /// Delete Button
                          IconButton(
                            onPressed: () {
                              deleteTask(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Footer
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Created by Dev",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Add Task
  void addTask() {
    String task = txt1.text.trim();

    if (task.isNotEmpty) {
      setState(() {
        mylist.add(task);
        txt1.clear();
      });
    }
  }

  /// Edit Task
  void editTask(int index) {
    txt1.text = mylist[index];
    editingText = index;
  }

  /// Update Task
  void updateTask() {
    if (editingText != null && txt1.text.trim().isNotEmpty) {
      setState(() {
        mylist[editingText!] = txt1.text.trim();

        txt1.clear();
        editingText = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task Updated Successfully"),
        ),
      );
    }
  }

  /// Delete Task
  void deleteTask(int index) {
    setState(() {
      mylist.removeAt(index);
    });
  }
}
