//import 'package:firebase_core/firebase_core.dart';import 'account/acount.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_app/saved/saved.dart';
import 'package:property_app/account/account.dart';
import 'package:property_app/home/home_section.dart';
import 'package:property_app/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home/property_item.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}




class MyApp extends StatefulWidget {
  List<PropertyItem> items=[];
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage=0;
  PageController pageController=PageController(initialPage: 0,keepPage: false);

  @override
  void initState() {
    super.initState();
    widget.items=[
      PropertyItem(
          id: 1,
          type: "apartment",
          cost: 2000.2,
          position : Point<double>(19.812487, 41.320874),
          beds: 2,
          parkPlaces: 1,
          baths: 2,
          description: "luxurious room in apartment",
          categories: List.from(["1 room", "condo"]),
          imagePath: List.from(["assets/room1.jpg","assets/room2.jpg","assets/room3.jpg"])
      ),
      PropertyItem(
          id: 2 ,
          type: "hotel",
          cost: 2400.2,
          position : Point<double>(20.312487, 40.920874),
          beds: 5,
          description: "luxurious hotel",
          categories: List.from(["1 room", "condo"]),
          imagePath: List.from(["assets/room2.jpg","assets/room1.jpg","assets/room3.jpg","assets/room3.jpg","assets/room3.jpg"])
      ),
      PropertyItem(
          id: 3 ,
          type: "villa",
          cost: 2400.2,
          position : Point<double>(20.312487, 40.920874),
          beds: 5,
          description: "luxurious villa",
          categories: List.from(["1 room", "condo"]),
          imagePath: List.from(["assets/room3.jpg","assets/room1.jpg","assets/room2.jpg"])
      )
    ];
  }

  setPage({required int page, bool scrolling= false}){
    setState(() {
      int diff=(currentPage-page).abs();
      currentPage=page;
      print(currentPage);
      if(!scrolling) {
        pageController.animateToPage(
          page, duration: Duration(milliseconds: diff*250), curve: Curves.easeInOut
        );
      }
    });
  }

  refresh(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
        children:[
          Positioned(
            top:0,
            left:0,
            child: Container(
              width: size.width,
              height: size.height,
              child: PageView(
                onPageChanged: (index){
                  setPage(page: index, scrolling: true);
                },
                children: <Widget>[
                  Home(items: widget.items, refresh: refresh),
                  Saved(items: widget.items, refresh: refresh),
                  Account(refresh: refresh),
                ],
                controller: pageController,
              ),
            )
          ),
          Positioned(
            top: size.height-105,
            left: 0,
            width: size.width,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: (){
                      setPage(page: 0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: currentPage==0
                        ? Colors.blue[400]
                        : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      setPage(page: 1);
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: currentPage==1
                        ? Colors.blue[400]
                        : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      setPage(page: 2);
                    },
                    icon: Icon(
                      Icons.person,
                      color: currentPage==2
                        ? Colors.blue[400]
                        : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
