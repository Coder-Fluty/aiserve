import 'package:aiserve/Pages/home_page.dart';
import 'package:flutter/material.dart';

void main() =>  runApp(new MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.grey.shade900)
    );
  }
}