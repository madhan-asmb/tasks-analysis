import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Tasks'),
          onPressed: () {},
        ),
        body: Center(
          child: Text('Tasks Page'),
        ),
      ),
    );
  }
}
