import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request/model/photos.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Todos> photo = [];

  Future fetchTodo() async {
    http.Response request = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/photos?_star=0&_limit=20",
      ),
    );
    setState(() {
      photo = (jsonDecode(request.body) as List)
          .map(
            (json) => Todos.fromJson(json),
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
      appBar: AppBar(),
      body: Container(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: photo
            .map(
              (item) => Card(
                child: Image.network(
                  item.url,
                  fit: BoxFit.contain,
                ),
              ),
            )
            .toList(),
      )),
    );
  }
}