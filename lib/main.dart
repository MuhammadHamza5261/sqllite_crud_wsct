import 'package:flutter/material.dart';
import 'package:sqlite_crud_wsct/data/local/db_helper.dart';
import 'package:sqlite_crud_wsct/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // DbHelper db = DbHelper.getInstance();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

