import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_analysis/models/user_model.dart';
import 'package:task_analysis/provider/auth_provider.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> data = [];
    readUsers() async {
      data = Provider.of<AuthProvider>(context).users;
    }

    readUsers();
    print(data);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Note'),
          onPressed: () {},
        ),
        body: Center(
          child: Column(children: data.map((e) => Text(e.name)).toList()),
        ),
      ),
    );
  }
}
