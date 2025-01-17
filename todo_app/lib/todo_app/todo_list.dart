import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isloading = true;
  List items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text("TODO APP using API"),
      ),
      body: Visibility(
        visible: isloading,
        child:Center(child: CircularProgressIndicator(),),
        replacement: 
        RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Todo"),
        onPressed: ToNavigateToAddPage,
      ),
    );
  }

  void ToNavigateToAddPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTodoPage();
    }));
  }

  Future<void> fetchTodo() async {
   
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      print("Data is not Coming");
    }
    setState(() {
      isloading = false;
    });
  }
}
