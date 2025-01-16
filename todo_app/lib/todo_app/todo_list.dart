
import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: Text("TODO APP using API"),
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
}
