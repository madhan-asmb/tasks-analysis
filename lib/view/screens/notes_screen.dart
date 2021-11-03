import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Note'),
          onPressed: () {},
        ),
        body: Center(
          child: Text('Notes Page'),
        ),
      ),
    );
  }
}
