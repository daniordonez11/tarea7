import 'package:flutter/material.dart';
import 'package:tarea7/widgets/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Stream App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}