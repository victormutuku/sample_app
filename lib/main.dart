import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/first_issue.dart';
import 'package:sample_app/items.dart';
import 'package:sample_app/second_issue.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Items(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          FirstIssueScreen.routeName: (context) => const FirstIssueScreen(),
          SecondIssueScreen.routeName: (context) => const SecondIssueScreen(),
        },
      ),
    );
  }
}
