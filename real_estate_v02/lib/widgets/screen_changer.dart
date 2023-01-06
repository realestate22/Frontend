import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_v02/provider/item_provider.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'dart:developer';
import 'package:real_estate_v02/widgets/screen_navigator_bar.dart';
import '../provider/screen_controller.dart';
import '../screens/account.dart';
import '../screens/home.dart';
import '../screens/post.dart';
import '../screens/saved.dart';


class ScreenChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenShown()
    );
  }
}



class ScreenShown extends StatefulWidget {
  @override
  State<ScreenShown> createState() => _ScreenShownState();
}

class _ScreenShownState extends State<ScreenShown> {
  late HomeScreen homeScreen;
  late SavedScreen savedScreen;
  late PostScreen postScreen;
  late AccountScreen accountScreen;
  late PageController pageController;

  @override
  void initState() {
    homeScreen = HomeScreen();
    savedScreen = SavedScreen();
    postScreen = PostScreen();
    accountScreen = AccountScreen();

    pageController = PageController(initialPage: 0, keepPage: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context , constraints ) {
        double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio
        ).bottom;
        double navigationDisplacement = constraints.maxHeight + keyboardHeight
          - 2 * DefaultProperty.instance.spacing.sideMargins -
            DefaultProperty.instance.sizes.navigationHeight;
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Consumer<ScreenController>(
                builder: (context, value, child) {//such that this can happen after pageView can add their items
                  if(value.isFromAppBar()){//only if an appbar icon tab has been clicked
                    pageController.jumpToPage(value.getCurrentPage());
                    // .animateToPage(
                    //   screenController.getCurrentPage(),
                    //   duration: Duration(milliseconds: screenController.getDifference()*250 == 0 ? 1: screenController.getDifference()*250),
                    //   curve: Curves.easeInOut
                    // );
                    value.setFromAppBar(false); //set such that it can be scrolled again like a page view
                  }
                  return PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index){// if it is scrollable physics
                      if(!value.isFromAppBar()){// if it has a request by an app bar tab prioritise that
                        value.setCurrentPage(index);// if no requests then change page due to scrolling
                      }
                    },
                    controller: pageController,
                    children: [
                      homeScreen,
                      savedScreen,
                      postScreen,
                      accountScreen,
                    ]
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: navigationDisplacement),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    DefaultProperty.instance.spacing.borderRadius
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                width: constraints.maxWidth,
                height: DefaultProperty.instance.sizes.navigationHeight,
                margin: EdgeInsets.all(
                    DefaultProperty.instance.spacing.sideMargins
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      color: DefaultProperty.instance.colors.blurColor,
                      child: ScreenNavigator()
                    )
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

