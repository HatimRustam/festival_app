import 'dart:math';

import 'package:festival_app/thired_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class second_screen extends StatefulWidget {
  final String category_name;
  final List<QuoteModel>quotelist;
  const second_screen({super.key, required this.category_name, required this.quotelist});

  @override
  State<second_screen> createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("width == " + width.toString());
    print("height == " + height.toString());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(CupertinoIcons.back)),
        title: Text(widget.category_name!),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: widget.quotelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => thired_screen(quotes:widget.quotelist[index].quote!,),));
              },
              child: Container(
                width: double.infinity,
                height: height * 25 /100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                child: Center(
                  child: Container(
                    width: width * 80 / 100,
                    child: Text(widget.quotelist[index].quote!,textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
