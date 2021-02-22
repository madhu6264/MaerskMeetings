import 'package:book_meetings/features/home/view/home_screen.dart';
import 'package:book_meetings/features/settings/view/settings_screen.dart';
import 'package:book_meetings/features/settings/view_model/settings_viewmodel.dart';
import 'package:book_meetings/features/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/view_model/home_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => SettingsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        title: "Maersk Meetings",
        routes: {
          '/': (context) => SplashScreen(),
          '/home': (context) => HomeScreen(),
          '/settings': (context) => SettingsScreen()
        },
      ),
    ),
  );
}
