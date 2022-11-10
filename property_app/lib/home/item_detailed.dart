import 'package:flutter/material.dart';
import 'package:property_app/home/location_button.dart';
import 'package:property_app/home/property_item.dart';

class ItemDetailed extends StatefulWidget {
  PropertyItem propertyItem;
  VoidCallback? refresh;
  ItemDetailed({required this.propertyItem, this.refresh}){

  }

  @override
  State<ItemDetailed> createState() => _ItemDetailedState();
}

class _ItemDetailedState extends State<ItemDetailed> {
  int currentView=0;

  updateBookMark(){
    setState(() {
      widget.propertyItem.bookmarked=!widget.propertyItem.bookmarked;
    });
  }

  setCurrentView(int curView){
    setState(() {
      currentView=curView;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: size.width,
            height: size.height/2,
            child: Stack(
              children: [
                Positioned(
                  width: size.width,
                  height: size.height/2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage(
                          widget.propertyItem.imagePath[currentView]
                        ),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white
                                )
                            ),
                            IconButton(
                              onPressed: () {
                                updateBookMark();
                                widget.refresh!();
                              },
                              icon: Icon(
                                widget.propertyItem.bookmarked
                                    ? Icons.bookmark_add
                                    :Icons.bookmark_add_outlined,
                              ),
                              color: widget.propertyItem.bookmarked
                                  ? Colors.pink
                                  : Colors.white,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
                                    child: Text(
                                      "\$ ${widget.propertyItem.cost}",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                        "${widget.propertyItem.type}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "${widget.propertyItem.description}",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          ),
                          LocationButton(
                            longitude: widget.propertyItem.position.x,
                            latitude: widget.propertyItem.position.y
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: size.width,
                            height: 1,
                            color: Colors.grey,
                          )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bed,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${widget.propertyItem.beds} Beds",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bathtub_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${widget.propertyItem.baths} Baths",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_parking,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${widget.propertyItem.parkPlaces} Parking",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(widget.propertyItem.imagePath.length, (index){
                return GestureDetector(
                  onTap: (){
                    setCurrentView(index);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.propertyItem.imagePath[index]),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding:EdgeInsets.all(15),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cinema"),
                      Text("45m")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cinema"),
                      Text("45m")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Cinema"),
                      Text("45m")
                    ],
                  ),
                ),

              ],
            ),
          ),
          TextButton(
            onPressed: (){
              print("Validate");
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              width: size.width,
              child: Center(
                child: Text(
                  "Validate",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.green[400],
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.all(15),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ut viverra libero, id mattis massa. Integer mollis fermentum dui at elementum. Quisque pretium, neque id elementum ultrices, metus arcu ultricies ligula, elementum accumsan ipsum mi eget lectus. Pellentesque congue, tortor vitae imperdiet gravida, dui tortor vestibulum orci, vel placerat mi nulla in leo. Aliquam rhoncus eros vitae est tincidunt tristique eu eget mi."
            ),//lorem
          )
        ],
      ),
    );
  }
}
