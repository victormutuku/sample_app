import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/items.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Items>(context).sqValues();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Consumer<Items>(
                  builder:(context, item, _) =>
                  ListTile(
                    title: Text(item.sqItems[index].toString()),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
