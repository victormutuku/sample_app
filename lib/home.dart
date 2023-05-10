import 'package:flutter/material.dart';
import 'package:sample_app/first_issue.dart';

import 'second_issue.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FirstIssueScreen.routeName);
              },
              child: const Text('Issue 1'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SecondIssueScreen.routeName);
              },
              child: const Text('Issue 2'),
            ),
          ],
        ),
      ),
    );
  }
}
