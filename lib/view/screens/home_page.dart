import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_analysis/provider/home_page_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<HomePageProvider>(context, listen: false)
                  .toggleTheme();
            },
            icon: Icon(
              Icons.nightlight_round_outlined,
            ),
          )
        ],
      ),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
