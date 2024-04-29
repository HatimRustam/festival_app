import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:share_it/share_it.dart';

class thired_screen extends StatefulWidget {
  final String quotes;

  const thired_screen({super.key, required this.quotes});

  @override
  State<thired_screen> createState() => _thired_screenState();
}

class _thired_screenState extends State<thired_screen> {
  List<Color> colorlist = [
    Colors.pink,
    Colors.green,
    Colors.deepOrangeAccent,
    Colors.indigo,
    Colors.teal,
    Colors.lime,
    Colors.amber,
    Colors.lightGreen,
    Colors.black,
    Colors.lightBlueAccent,
  ];
  List<String> fontlist = [
    "BebasNeue",
    "Damion",
    "Italianno",
    "Sedan",
    "ShortStack ",
  ];

  Color? colorValue;
  Color? backgroundValue;
  String? fontValue;

  @override
  void initState() {
    // TODO: implement initState
    colorValue = colorlist.first;
    backgroundValue = colorlist.last;
    fontValue = fontlist.first;
    super.initState();
  }

  GlobalKey<State<StatefulWidget>> widget1RenderKey =
  GlobalKey<State<StatefulWidget>>();

  Uint8List? uint8List;

  downloadImage() async {
    final RenderRepaintBoundary boundary = widget1RenderKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 1.5);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    uint8List = byteData!.buffer.asUint8List();
    final directory = await getDownloadsDirectory();
    print(directory!.path);
    File file = File('${directory!.path}/image1.png');
    try {
      await file.writeAsBytes(uint8List!.toList());
      return file.path;
    } on Exception catch (e) {
      // TODO
      print(e);
    }
    setState(() {});
  }

  shareImage(path) async {
    await ShareIt.file(path: path, type: ShareItFileType.image);
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("width == " + width.toString());
    print("height == " + height.toString());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                downloadImage();
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                String path = await downloadImage();
                shareImage(path);
              },
              icon: Icon(Icons.share))
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(CupertinoIcons.back)),
        title: Text("Edit Quote"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RepaintBoundary(
                key: widget1RenderKey,
                child: Container(
                  width: double.infinity,
                  height: height * 25 / 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundValue),
                  child: Center(
                    child: Container(
                      width: width * 80 / 100,
                      child: Text(
                        widget.quotes!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: colorValue,fontFamily: fontValue),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Text Color"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: colorlist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            colorValue = colorlist[index];
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: colorlist[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Background Color"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: colorlist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            backgroundValue = colorlist[index];
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: colorlist[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Font Style"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: fontlist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            fontValue = fontlist[index];
                          });
                        },
                        child: Container(
                          height: 30,
                          // width: 30,
                          child: Text(fontlist[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
