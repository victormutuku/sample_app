import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SecondIssueScreen extends StatelessWidget {
  static const routeName = "/secondscreen";

  const SecondIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.green,
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue 2'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => LiquidSwipe(pages: pages),
      ),
    );
  }
}
