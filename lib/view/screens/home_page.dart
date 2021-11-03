import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_analysis/models/user_model.dart';
import 'package:task_analysis/provider/auth_provider.dart';
import 'package:task_analysis/provider/home_page_provider.dart';
import 'package:task_analysis/view/screens/credit_cards_screen.dart';
import 'package:task_analysis/view/screens/notes_screen.dart';
import 'package:task_analysis/view/screens/profile_screen.dart';
import 'package:task_analysis/view/screens/tasks_screen.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<User> data = [];
//     readUsers() async {
//       data = Provider.of<AuthProvider>(context).users;
//     }
//     readUsers();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Provider.of<HomePageProvider>(context, listen: false)
//                   .toggleTheme();
//             },
//             icon: Icon(
//               Icons.nightlight_round_outlined,
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.note_alt_outlined),
//       ),
//       body: Column(children: data.map((e) => Text(e.name)).toList()),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    NotesPage(),
    TasksPage(),
    CreditCardPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this loses the state
      //body: _screens[_currentIndex],
      //this hold the state of a screen
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Credit cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
