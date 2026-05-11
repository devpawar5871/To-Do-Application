import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    title: "Navigation App",
    home: MyApp(),
    initialRoute: "Home",
    routes: {
      "Home": (context) => const MyApp(),
    },
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txt1 = TextEditingController();

  var mylist = [];
  int? editingText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do App"),
        backgroundColor: const Color.fromARGB(255, 207, 121, 121),
      ),
      body: Column(
        children: [
          TextField(controller: txt1),
          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              result();
            },
            child: Text("Add Task"),
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              edittext();
            },
            child: Text("Update Task"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text("$index")),
                  title: Text(mylist[index]),
                  subtitle: Text("Task Item"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          edit(index);
                        },
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () {
                          delete(index);
                        },
                        icon: Icon(Icons.delete_forever, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ✅ Footer Text (Correct Place)
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Created by Dev",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void result() {
    var sub1 = txt1.text;
    setState(() {
      mylist.add(sub1);
      txt1.clear();
    });
  }

  void edit(index) {
    setState(() {
      txt1.text = mylist[index].toString();
      editingText = index;
    });
  }

  void edittext() {
    if (editingText != null) {
      setState(() {
        mylist[editingText!] = txt1.text;
        txt1.clear();
        editingText = null;
      });
    }
  }

  void delete(int index) {
    setState(() {
      mylist.removeAt(index);
    });
  }
}