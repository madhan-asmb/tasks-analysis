import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_analysis/helpers/app_themes.dart';
import 'package:task_analysis/provider/auth_provider.dart';
import 'package:task_analysis/provider/credit_card_provider.dart';
import 'package:task_analysis/provider/home_page_provider.dart';

import 'view/screens/auth_screen.dart';
import 'view/screens/onboarding_screen.dart';

int initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen") ?? 0;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<HomePageProvider>(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider<CreditCardProvider>(
          create: (_) => CreditCardProvider(),
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
      home: initScreen == 1 ? AuthScreen() : OnBoardingPage(),
    );
  }
}
