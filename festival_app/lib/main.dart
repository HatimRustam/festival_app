import 'dart:math';

import 'package:festival_app/model.dart';
import 'package:festival_app/second_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool isswitch = false;

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> quotedata = [
    {
      "category_id": "1",
      "category_name": "Diwali",
      "category_image": "assets/images/diwali.png",
      "quotes": [
        {"quote_id": "1", "quote": "The Grand Festival Of Lights"},
        {
          "quote_id": "2",
          "quote":
              "Diwali is a time to celebrate the victory of good over evil, light over darkness, and knowledge over ignorance."
        },
        {
          "quote_id": "3",
          "quote":
              "On Diwali, let's light up not just our homes, but also our hearts."
        },
        {
          "quote_id": "4",
          "quote":
              "May the festival of Diwali bring you new beginnings, new hopes, and new dreams."
        },
        {
          "quote_id": "5",
          "quote":
              "Diwali is a time to reflect on the blessings in our lives and to be grateful for all that we have."
        },
      ]
    },
    {
      "category_id": "2",
      "category_name": "Holi",
      "category_image": "assets/images/holi.png",
      "quotes": [
        {"quote_id": "1", "quote": "The Vibrant Festival Of Colours"}
      ]
    },
    {
      "category_id": "3",
      "category_name": "Dussehra",
      "category_image": "assets/images/ravan.png",
      "quotes": [
        {"quote_id": "1", "quote": "Witness The Triumph Of Good Over Evil"}
      ]
    },
    {
      "category_id": "4",
      "category_name": "Navratri",
      "category_image": "assets/images/diwali.png",
      "quotes": [
        {
          "quote_id": "1",
          "quote": "The Nine Days Of Fasting, Faith, & Devotion"
        }
      ]
    }
  ];
  List<CategoryModel> quoteList = [];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < quotedata.length; i++) {
      setState(() {
        quoteList.add(CategoryModel.fromJson(quotedata[i]));
      });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("width == " + width.toString());
    print("height == " + height.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes and Status News"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Switch(
              value: isswitch,
              onChanged: (value) {
                print(value);
                setState(() {
                  isswitch = value!;
                });
              },
            ),
          )
        ],
      ),
      body: (isswitch == true)
          ? ListView.builder(
              itemCount: quoteList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => second_screen(
                            category_name: quoteList[index].categoryName!,
                            quotelist: quoteList[index].quoteList!),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              quoteList[index].categoryName!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image(
                                image:
                                    AssetImage(quoteList[index].categoryImage!),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : GridView.builder(
              itemCount: quoteList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => second_screen(
                            category_name: quoteList[index].categoryName!,
                            quotelist: quoteList[index].quoteList!),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              quoteList[index].categoryName!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image(
                                image:
                                    AssetImage(quoteList[index].categoryImage!),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
