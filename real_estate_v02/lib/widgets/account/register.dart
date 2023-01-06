import 'package:flutter/material.dart';
import 'package:real_estate_v02/widgets/account/splitter.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/post/icon_change.dart';
import 'package:real_estate_v02/widgets/post/number_user_form.dart';
import 'package:real_estate_v02/widgets/post/password_user_form.dart';
import 'package:real_estate_v02/widgets/post/search_user_form.dart';
import 'package:real_estate_v02/widgets/post/selection_user_form.dart';
import 'package:real_estate_v02/widgets/post/submit_user_form.dart';
import 'package:real_estate_v02/widgets/post/text_user_form.dart';

import '../post/email_user_form.dart';
import '../text_widget.dart';

class Register extends StatefulWidget {
  Size? size;
  Register({required this.size}){

  }
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<Widget> userForms=[];
  late SubmitUserForm googleButton;

  @override
  void initState() {

    userForms.add(
        TextUserForm(
          prefixIcon: Icons.person_outline,
          placeholder: "Username",
          validate: {
            "^[a-zA-Z0-9!-_@]{8,34}\$": "Not a valid username!"
          },
          action: (){
            FocusScope.of(context).unfocus();
          },
        )
    );

    userForms.add(
        PasswordUserForm(
            prefixIcon: Icons.lock_outline_rounded,
            placeholder: "Repeat password",
            action: (){
              FocusScope.of(context).requestFocus(
                  (userForms[0] as TextUserForm).focusNode
              );
            }
        )
    );
    userForms.add(
        PasswordUserForm(
            prefixIcon: Icons.lock_outline_rounded,
            placeholder: "Create password",
            action: (){
              FocusScope.of(context).requestFocus(
                  (userForms[1] as PasswordUserForm).focusNode
              );
            }
        )
    );

    userForms.add(
      NumberUserForm(
        prefixIcon: Icons.phone,
        placeholder: "Cell number",
        action: (){
          FocusScope.of(context).requestFocus(
              (userForms[2] as PasswordUserForm).focusNode
          );
        }
      )
    );
    userForms.add(
        EmailUserForm(
          prefixIcon: Icons.mail_outline,
            placeholder: "Email",
            action: (){
              FocusScope.of(context).requestFocus(
                  (userForms[3] as NumberUserForm).focusNode
              );
            }
        )
    );

    userForms.add(
        SubmitUserForm(
          text: "Submit",
          action: (){
            FocusScope.of(context).unfocus();
          },
          backgroundColor: DefaultProperty.instance.colors.mainIndigo,
          foregroundColor: Colors.white,
        )
    );

    googleButton=SubmitUserForm(
        icon: DefaultProperty.instance.images.googleIcon,
        text: "Google",
        buttonSize: 22,
        action: (){
          FocusScope.of(context).unfocus();
        }
    );

    (userForms[1] as PasswordUserForm).addControllerToMatchTo(
        (userForms[2] as PasswordUserForm).textEditCon
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: DefaultProperty.instance.spacing.sideMargins * 2
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom:DefaultProperty.instance.spacing.sideMargins/2
              ),
              child: TextWidget(
                text: "Create a new account!",
                family: "Poppins",
                size: 20,
              ),
            ),
            Column(
              children: [
                ...userForms.sublist(0,userForms.length-1).reversed.toList(),
                Container(
                    width: double.infinity,
                    child: userForms.last
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Column(
                      children: [
                        TextWidget(
                          text: "By creating an account, you agree to Real Occasion",
                          family: "Avenir",
                          size: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                FocusScope.of(context).unfocus();

                              },
                              child: TextWidget(
                                text: "Terms of use",
                                family: "Avenir",
                                color: DefaultProperty.instance.colors.mainIndigo,
                                size: 12,
                              ),
                            ),
                            TextWidget(
                              text: " and ",
                              family: "Avenir",
                              size: 12,
                            ),
                            GestureDetector(
                              onTap: (){
                                FocusScope.of(context).unfocus();

                              },
                              child: TextWidget(
                                text: "Privacy policy",
                                family: "Avenir",
                                color: DefaultProperty.instance.colors.mainIndigo,
                                size: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: DefaultProperty.instance.spacing.sideMargins
                  ),
                  child: Splitter(
                    size: 16,
                    text: "or connect with",
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: googleButton
                ),
                SizedBox(
                  height: DefaultProperty.instance.spacing.sideMargins * 2 +
                    DefaultProperty.instance.sizes.navigationHeight
                )
              ],
            ),

          ],
        )
    );
  }
}
