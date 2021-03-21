import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request/model/todo.dart';
import 'package:http_request/screen/gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];

  Future fetchTodo() async {
    http.Response request = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos",
      ),
    );
    setState(() {
      todos = (jsonDecode(request.body) as List)
          .map(
            (json) => Todo.fromJson(json),
          )
          .toList();
    });
  }

  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryScreen(),
                  ),
                );
              },
              leading: Icon(Icons.picture_in_picture),
              title: Text("Gallery"),
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: todos
              .map(
                (item) => Card(
                  child: ListTile(
                    title: Text(
                      item.title,
                    ),
                    subtitle: item.completed ? Text("เสร็จ") : Text("ไปทำ"),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
