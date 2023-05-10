import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'items.dart';

class FirstIssueScreen extends StatefulWidget {
  static const routeName = "/firstscreen";

  const FirstIssueScreen({super.key});

  @override
  State<FirstIssueScreen> createState() => _FirstIssueScreenState();
}

class _FirstIssueScreenState extends State<FirstIssueScreen> {
  late PageController controller;
  int currentpage = 0;
  int myValue = 0;
  int questionNumber = 1;

  @override
  initState() {
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.8,
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
    final containerHeight =
        myValue == 0 ? deviceHeight * 0.1 : deviceHeight * 0.4;
    final items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue 1'),
        centerTitle: true,
        actions: [
          myValue == 0
              ? const SizedBox()
              : TextButton(
                  onPressed: () {
                    setState(() {
                      myValue = 0;
                    });
                  },
                  child: const Text(
                    'Revert',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: myValue == 0
                      ? Hero(
                          tag: myValue,
                          child: SizedBox(
                            height: deviceHeight * 0.3,
                            child: PageView.builder(
                              itemCount: items.length,
                              onPageChanged: (value) {},
                              controller: controller,
                              itemBuilder: (context, index) => builder(index),
                            ),
                          ),
                        )
                      : AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInCubic,
                          height: containerHeight,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Card(
                            color: const Color.fromARGB(255, 165, 214, 255),
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      height: containerHeight < 100 ? 10 : 100,
                                    ),
                                    Text(
                                      myValue.toString(),
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                    containerHeight < 100
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 4,
                                                  ),
                                                  side: BorderSide.none,
                                                ),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons
                                                        .play_arrow_outlined),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('Watch Now')
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 4,
                                                  ),
                                                  side: BorderSide.none,
                                                ),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.add),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('WishList')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            ),
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
          height: Curves.easeOut.transform(value) * 400,
          width: Curves.easeOut.transform(value) * 400,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
          color: Colors.amber,
        ),
      ),
    );
  }
}
