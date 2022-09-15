import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:qualif/item.dart';
import 'package:qualif/review.dart';
import 'package:qualif/theme.dart';

class DetailPage extends StatefulWidget {
  Item item;
  String email;
  DetailPage({super.key, required this.item, required this.email});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController reviewController = TextEditingController();

  var reviews = [
    Review(email: 'email1@email.com', review: 'This food is good'),
    Review(email: 'email2@email.com', review: 'This food is also good'),
    Review(email: 'email3@email.com', review: 'This food is very good'),
  ];

  void handleReview() {
    String rev = reviewController.text;
    if (rev == '') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review must not be empty.")));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Review is sent.")));
    reviews.add(Review(email: widget.email, review: rev));
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Food Details"),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.comment))
            ]),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: PopupMenuButton(
                  child: const Center(child: Icon(Icons.more_vert)),
                  itemBuilder: (context) {
                    return List.generate(1,
                    (index) => (PopupMenuItem(
                          child: const Text("Toggle Light or Dark"),
                          onTap: () {
                            ThemeProvider themeProvider =
                                Provider.of<ThemeProvider>(context,
                                    listen: false);
                            themeProvider.swapTheme();
                          },
                        )
                      )
                    );
                  },
                ),
              )
            ],
          ),
          body: TabBarView(children: [
            Container(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                Image.asset(
                  widget.item.image,
                  height: 150,
                ),
                Text(widget.item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, height: 1, fontSize: 30)),
                Text(widget.item.desc,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, height: 1, fontSize: 15)),
                Text(widget.item.price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Review',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: handleReview, child: const Text("Send Review"))
              ]),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Expanded(
                    child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(reviews[index].email,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                fontSize: 18)),
                        Text("${reviews[index].review} \n",
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                height: 1.5,
                                fontSize: 20)),
                      ],
                    );
                  },
                )))
          ]),
        ));
  }
}
