import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_analysis/helpers/app_themes.dart';
import 'package:task_analysis/provider/home_page_provider.dart';

import 'view/screens/home_page.dart';
import 'view/screens/onboarding_screen.dart';

int initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen") ?? 0;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Analysis',
      theme: AppThemes.mountainHaze,
      darkTheme: AppThemes.dark,
      themeMode: Provider.of<HomePageProvider>(context).isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      home: initScreen == 1 ? HomePage() : OnBoardingPage(),
    );
  }
}
