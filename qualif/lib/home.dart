import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:qualif/homedetail.dart';
import 'package:qualif/items.dart';
import 'package:qualif/login.dart';
import 'package:qualif/theme.dart';

class HomePage extends StatelessWidget {
  String email;
  HomePage({super.key, required this.email});

  var images = ["assets/car1.jpg", "assets/car2.jpg", "assets/car3.jpg"];
  var homedet = [
    Homedetail(
        image: "assets/home1.jpg",
        heading:
            "You can now enjoy the Gopud service in 74 cities across Indonesia!",
        desc:
            "We will keep expanding our service areas, so people all across Indonesia can conveniently order their favourite food! Whilst also helping SMEs to reach the market so they can further flourish."),
    Homedetail(
        image: "assets/home2.jpg",
        heading: "We have lotttttts of merchant partners",
        desc:
            "550,000 merchants in Indonesia ready to deliver a variety of food right in front of your doorstep!"),
    Homedetail(
        image: "assets/home3.jpg",
        heading: "Order GoFood = contribution to society",
        desc:
            "Do you realize that your order improve the Indonesian economy as well as the Indonesian society? Contributing IDR19 trillion in 2018!"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
        body: Column(
          children: [
            CarouselSlider(
                items: images.map((e) => Image.asset(e)).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3))),
            Expanded(
                child: ListView.builder(
              itemCount: homedet.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(homedet[index].image),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 2),
                      child: Text(
                        homedet[index].heading,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 10),
                      child: Text("${homedet[index].desc} \n",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1,
                              fontSize: 15),
                          textAlign: TextAlign.center),
                    )
                  ],
                );
              },
            ))
          ],
        ));
  }
}
