import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

Future  fetchTodo() async {
  http.Response request = await  http.get(
    Uri.parse(
    "https://jsonplaceholder.typicode.com/todos",
    ),
  );
  print(request.body);
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
        title:Text(
          "Home Screen",
          ),
      ),
      body: Container(
        child: Center(),
      ),
    );
  }
}