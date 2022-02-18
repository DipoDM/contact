import 'package:contact/Views/add_contact_page.dart';
import 'package:contact/Views/edit_detail_page.dart';
import 'package:contact/Views/home_page.dart';
import 'package:contact/Views/intro_screen.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:contact/Views/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // showSemanticsDebugger: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: kVisaGold,
      ),
      //home: const IntroScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroScreen(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => DetailPage(), // pass argument
        '/edit': (context) => EditPage(), // pass argument
        '/new_contact': (context) => NewContactPage(),
      },
    );
  }
}
