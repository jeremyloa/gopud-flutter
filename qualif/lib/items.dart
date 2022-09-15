import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:qualif/details.dart';
import 'package:qualif/home.dart';
import 'package:qualif/item.dart';
import 'package:qualif/login.dart';
import 'package:qualif/theme.dart';

class ItemsPage extends StatelessWidget {
  String email;
  ItemsPage({super.key, required this.email});

  var items = [
    Item(
        image: 'assets/1.jpg',
        name: 'Fried Chicken',
        desc: '1 Pcs Chicken',
        price: '22.501'),
    Item(
        image: 'assets/2.jpg',
        name: 'Whole Chicken Bucket',
        desc: 'Whole Chicken Bucket',
        price: '187.501'),
    Item(
        image: 'assets/3.jpg',
        name: 'Coca Cola',
        desc: 'Your favorite drink',
        price: '14.000')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foods"),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: PopupMenuButton(
              child: const Center(child: Icon(Icons.more_vert)),
              itemBuilder: (context) {
                return List.generate(
                    1,
                    (index) => (PopupMenuItem(
                          child: const Text("Toggle Light or Dark"),
                          onTap: () {
                            ThemeProvider themeProvider =
                                Provider.of<ThemeProvider>(context,
                                    listen: false);
                            themeProvider.swapTheme();
                          },
                        )));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text(email)),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePage(email: email);
                  },
                ), (route) => false);
              },
            ),
            ListTile(
              title: const Text("Foods"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ItemsPage(email: email);
                  },
                ));
              },
            ),
            ListTile(
              title: const Text("Sign Out"),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ), (route) => false);
              },
            )
          ],
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(0),
          child: Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(items[index].image),
                  Text(items[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 2,
                          fontSize: 30)
                        ),
                  Text(items[index].desc,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          height: 1,
                          fontSize: 15)
                        ),
                  Text(items[index].price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          fontSize: 30)
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(item: items[index], email: email);
                            },
                          ));
                        },
                        child: const Text("View Detail")),
                  )
                ],
              );
            },
          ))),
    );
  }
}
