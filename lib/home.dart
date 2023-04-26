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
    final containerHeight =
        myValue == 0 ? deviceHeight * 0.1 : deviceHeight * 0.4;
    final items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        leading: myValue == 0
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    myValue = 0;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              ),
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
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
                            duration: const Duration(milliseconds: 1000),
                            height: containerHeight < 100 ? 10 : 100,
                          ),
                          Text(
                            myValue.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                          containerHeight < 100
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        side: BorderSide.none,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.play_arrow_outlined),
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
                                            const EdgeInsets.only(right: 4),
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
}
