import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/items.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController controller;
  int currentpage = 0;
  int myValue = 0;
  int questionNumber = 1;

  @override
  initState() {
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 1,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Items>(context, listen: false).sqValues();
    super.didChangeDependencies();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: deviceHeight * 0.5,
              //   child: PageView.builder(
              //     itemCount: items.length,
              //     onPageChanged: (value) {},
              //     controller: controller,
              //     itemBuilder: (context, index) => builder(index),
              //   ),
              // ),
              Container(
                height: deviceHeight * 0.4,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Card(
                  color: Colors.blue.withOpacity(0.3),
                  child: Center(
                    child: Text(
                      myValue.toString(),
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Consumer<Items>(
                      builder: (context, item, _) => ListTile(
                        onTap: () {
                          setState(() {
                            myValue = item.sqItems[index];
                          });
                        },
                        title: Text(
                          item.sqItems[index].toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  builder(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page! - index;
          value = (1 - (value.abs() * .4)).clamp(0.0, 1.0);
        }
        return SizedBox(
          height: Curves.easeOut.transform(value) * 300,
          width: Curves.easeOut.transform(value) * 300,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Card(
          color: Colors.blue.withOpacity(0.3),
          child: Center(
            child: Text(
              index.toString(),
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }
}
