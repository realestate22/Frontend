import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import '../provider/screen_controller.dart';

class ScreenNavigator extends StatelessWidget {

  late List<IconButton> iconButtons;

  @override
  Widget build(BuildContext context) {
    iconButtons = [
      iconToButton(Icons.home, 0, context),
      iconToButton(Icons.bookmark, 1, context),
      iconToButton(Icons.add, 2, context),
      iconToButton(Icons.person, 3, context),
    ];

    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: iconButtons

      )
    );
  }

  IconButton iconToButton(IconData data, int pos, BuildContext context) {
    final screenController = Provider.of<ScreenController>(context);
    return IconButton(
      onPressed: (){
        screenController.setFromAppBar(true);// send a request to prioritise app bar tab clicked
        screenController.setCurrentPage(pos);// request to which page
      },
      icon: Icon(
        color : screenController.getCurrentPage() == pos
            ? DefaultProperty.instance.colors.mainIndigo : Colors.grey,
        data
      )
    );
  }
}
