import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/text_widget.dart';

import '../widgets/account/register.dart';
import '../widgets/account/sign_up.dart';
import '../widgets/default_property.dart';

class AccountScreen extends StatefulWidget {

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>{

  bool signIn = true;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
      keepPage: true,
    );

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        Rect rect = Rect.fromLTWH(
          (signIn ? 0 : 1 ) * constraint.maxWidth/2,
          DefaultProperty.instance.sizes.registerHeight-
              DefaultProperty.instance.sizes.borderSize,
          constraint.maxWidth/2,
          DefaultProperty.instance.sizes.borderSize
        );
        return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
          },
          child: Scaffold(
            backgroundColor: DefaultProperty.instance.colors.backgroundColor,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: DefaultProperty.instance.spacing.sideMargins * 3,
                    bottom: DefaultProperty.instance.spacing.sideMargins * 2
                  ),
                  width: constraint.maxWidth,
                  color: DefaultProperty.instance.colors.mainIndigo,
                  child: Center(
                    child: Container(
                      height: DefaultProperty.instance.sizes.logoDisplaySize,
                      child: DefaultProperty.instance.images.logoWhite,
                    )
                  ),
                ),
                SizedBox(
                  width: constraint.maxWidth,
                  height: DefaultProperty.instance.sizes.registerHeight,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                setSignIn(true);
                              },
                              child: Center(
                                child: TextWidget(
                                  text: "Sign in",
                                  color: signIn ?
                                  DefaultProperty.instance.colors.mainIndigo :
                                  DefaultProperty.instance.colors.lighterMainIndigo,
                                  family: "Roboto",
                                  size: 16,
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                setSignIn(false);
                              },
                              child: Center(
                                child: TextWidget(
                                  text: "Register",
                                  color: !signIn ?
                                  DefaultProperty.instance.colors.mainIndigo :
                                  DefaultProperty.instance.colors.lighterMainIndigo,
                                  family: "Roboto",
                                  size: 16,
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: rect.width,
                        height: rect.height,
                        margin: EdgeInsets.only(
                          top: rect.top,
                          left: rect.left,
                        ),
                        color: DefaultProperty.instance.colors.mainIndigo,
                      ),
                    ],
                  )
                ),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight
                    - DefaultProperty.instance.spacing.sideMargins * 5
                    - DefaultProperty.instance.sizes.logoDisplaySize
                    - DefaultProperty.instance.sizes.registerHeight,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setSignIn(value==0);
                    },
                    controller: _controller,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return [
                        SignUp(size: Size(constraint.maxWidth,
                            constraint.maxHeight
                                - DefaultProperty.instance.spacing.sideMargins * 5
                                - DefaultProperty.instance.sizes.logoDisplaySize
                                - DefaultProperty.instance.sizes.registerHeight
                            )),
                        Register(size: Size(constraint.maxWidth,constraint.maxHeight
                            - DefaultProperty.instance.spacing.sideMargins * 5
                            - DefaultProperty.instance.sizes.logoDisplaySize
                            - DefaultProperty.instance.sizes.registerHeight)),
                      ][index];
                    },
                  )
                )
              ],
            ),
          ),
        );
      }
    );

  }

  setSignIn(bool sIn){
    FocusScope.of(context).unfocus();
    if(signIn!=sIn) {
      setState(() {
        signIn = sIn;
        log(signIn.toString());
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _controller.animateToPage(
            signIn ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        });
      });
    }
  }
}
