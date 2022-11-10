import 'package:property_app/home/location_button.dart';
import 'package:property_app/home/property_item.dart';
import 'package:flutter/material.dart';
import 'package:property_app/home/item_detailed.dart';

class ItemCard extends StatefulWidget {
  PropertyItem propertyItem;
  VoidCallback? refresh;
  ItemCard({required this.propertyItem, this.refresh});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {


  updateBookMark(){
    setState(() {
      widget.propertyItem.bookmarked=!widget.propertyItem.bookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        print("clicked ${widget.propertyItem.id}");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ItemDetailed(propertyItem: widget.propertyItem, refresh: widget.refresh);
        }));
      },
      child: Container(//Item Booking
        margin: const EdgeInsets.only(bottom: 10,left : 35, right: 35),
        width: 340,
        decoration: const BoxDecoration(
          color: Color.fromARGB(128, 240, 192, 128),
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  //color: Colors.amber,
                  width: 340,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(128, 240, 192, 128),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.propertyItem.imagePath.isNotEmpty?
                      widget.propertyItem.imagePath.length:
                      widget.propertyItem.imagePath.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.propertyItem.imagePath.isNotEmpty
                        ?
                        Container(
                          width: 340,
                          decoration: BoxDecoration(//no other
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            image: DecorationImage(
                                image: AssetImage(
                                    widget.propertyItem.imagePath[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                        :
                        Container(
                          width: 340,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                            ),
                            color: Color.fromARGB(128, 240, 192, 128)
                          ),
                        )
                      ;
                    },
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.orange,
                      width: 300,
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        children:[
                          Row(
                            children:widget.propertyItem.categories.isEmpty ? [] :
                            widget.propertyItem.categories.map((String s) =>
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(64, 128, 128, 128),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Text(
                                  s,
                                  style: TextStyle(
                                    color: Colors.red[100]
                                  ),
                                ),
                              )
                            ).toList()
                          ),
                          const Spacer(),
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
                          )
                        ]
                      )
                    )
                  ]
                ),
                Positioned(
                  right:0,
                  bottom:0,
                  child: LocationButton(
                    longitude: widget.propertyItem.position.x,
                    latitude: widget.propertyItem.position.y,
                  )
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
                  child: Text(
                    "\$ ${widget.propertyItem.cost}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    "${widget.propertyItem.type}"
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${widget.propertyItem.description}"
                  ),
                ),
              ],
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
                          color: Colors.greenAccent,
                        ),
                        Text(
                          "${widget.propertyItem.beds} Beds"
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
                          color: Colors.greenAccent,
                        ),
                        Text(
                          "${widget.propertyItem.baths} Baths"
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
                          color: Colors.greenAccent,
                        ),
                        Text(
                          "${widget.propertyItem.parkPlaces} Parking"
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
    );
  }
}

