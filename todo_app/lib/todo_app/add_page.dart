import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("Add ToDo"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                label: Text("Title"),
              ),
            ),
            TextField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                label: Text("Description"),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue)),
                onPressed: SubmitData,
                child: Text("Submit"))
          ],
        ));
  }

  Future<void> SubmitData() async {
    //pahilo kam form bata data line
    final title = titlecontroller.text;
    final desciption = descriptioncontroller.text;

    final body = {
      "title": title,
      "description": desciption,
      "is_completed": false
    };

    //dosro kam tyo data lai server tira pathaune
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    //ra antyama tesro kam bhaneko serverma data
    //gaisakepachi user lai success bhanera dekhaune

    if (response.statusCode == 201) {
      titlecontroller.text = '';
      descriptioncontroller.text = '';
      print("Success");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Success to put data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
      print(response.statusCode);
    } else {
      print("Error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Faild to load data",
          style: TextStyle(color: Colors.white24),
        ),
        backgroundColor: Colors.red,
      ));
    }

    print(response.body);
  }

 
}
