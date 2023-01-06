import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:real_estate_v02/services/firebase_auth_user.dart';
import 'package:real_estate_v02/services/firebase_rtdb.dart';
import 'package:real_estate_v02/widgets/account/splitter.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/post/password_user_form.dart';
import 'package:real_estate_v02/widgets/post/submit_user_form.dart';
import 'package:real_estate_v02/widgets/text_widget.dart';

import '../modal_widget.dart';
import '../post/email_user_form.dart';

class SignUp extends StatefulWidget {

  Size? size;
  SignUp({required this.size}){
    log(size.toString());
  }
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  List<Widget> userForms=[];
  late SubmitUserForm googleButton;

  @override
  void initState() {

    userForms.add(
      PasswordUserForm(
        prefixIcon: Icons.lock_outline_rounded,
        placeholder: 'Password',
        buttonSize: DefaultProperty.instance.sizes.defaultFontSize,
        action: (){
          FocusScope.of(context).unfocus();
        },
      )
    );

    userForms.add(
      EmailUserForm(
        prefixIcon: Icons.mail_outline,
        placeholder: "Email",
        buttonSize: DefaultProperty.instance.sizes.defaultFontSize,
        action: (){
          FocusScope.of(context).requestFocus(
            (userForms[0] as PasswordUserForm).focusNode
          );
        },
      )
    );

    userForms.add(
      SubmitUserForm(
        text: "Sign in",
        action: () async{
          FocusScope.of(context).unfocus();
          String temp="";

          List<bool> areValidated=[];

          PasswordUserForm puf=(userForms[0] as PasswordUserForm);
          areValidated.add(puf.isValidated());
          temp=puf.textEditCon.text;
          puf.textEditCon.text+=" ";
          puf.textEditCon.text=temp;

          EmailUserForm euf=(userForms[1] as EmailUserForm);
          areValidated.add(euf.isValidated());
          temp=euf.textEditCon.text;
          euf.textEditCon.text+=" ";
          euf.textEditCon.text=temp;

          Future.delayed(const Duration(seconds: 1), (){
            puf.totalValidation=false;
            euf.totalValidation=false;
          });

          if(areValidated.every((element) => element)){
            await FirebaseAuthUser.instance.signInWithEmail(euf.textEditCon.text, puf.textEditCon.text);
            if(FirebaseAuthUser.instance.user!=null){
              log(FirebaseAuthUser.instance.user.toString());
            }
          }
          Navigator.push(context,MaterialPageRoute( builder: (context) {
            return Center(child: Text("sssss"),);
          },));
        },
        backgroundColor: DefaultProperty.instance.colors.mainIndigo,
        foregroundColor: Colors.white,
      )
    );
    googleButton=SubmitUserForm(
        icon: DefaultProperty.instance.images.googleIcon,
        text: "Google",
        buttonSize: 22,
        action: () async{
          FocusScope.of(context).unfocus();
          await FirebaseAuthUser.instance.signInWithGoogle();
          if(FirebaseAuthUser.instance.user!=null){
            log("User: "+FirebaseAuthUser.instance.user!.user.toString());
            ModalWidget.callModalWidget(
              context,
              ModalWidget(
                size: Size(widget.size!.width,widget.size!.height
                    - DefaultProperty.instance.spacing.sideMargins * 5
                    - DefaultProperty.instance.sizes.logoDisplaySize
                    - DefaultProperty.instance.sizes.registerHeight),
                position: Math.Point<double>(0,
                    DefaultProperty.instance.spacing.sideMargins * 5
                        + DefaultProperty.instance.sizes.logoDisplaySize
                        + DefaultProperty.instance.sizes.registerHeight),
                boxDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  children: [
                    EmailUserForm(placeholder: "Email", action: () {

                    },),
                    SubmitUserForm(text: "Get new Pass", action: () {

                    },)
                  ],
                ),
              )
            );
            // await FirebaseRTDB.instance.referenceFromDB("users",DataChange.Insert, FirebaseAuthUser.instance.user!.user!.uid, {
            //   "L":"S"
            // });
          }

        }
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
              bottom:DefaultProperty.instance.spacing.sideMargins / 2
            ),
            child: TextWidget(
              text: "Sign in to your account!",
              family: "Poppins",
              size: 20,
            ),
          ),
          Column(
            children: [
              ...userForms.sublist(0,userForms.length-1).reversed.toList(),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    log("Button clicked!!!");
                    ModalWidget.callModalWidget(
                        context,
                        ModalWidget(
                          size: Size(widget.size!.width,widget.size!.height
                              - DefaultProperty.instance.spacing.sideMargins * 5
                              - DefaultProperty.instance.sizes.logoDisplaySize
                              - DefaultProperty.instance.sizes.registerHeight),
                          position: Math.Point<double>(0,
                              DefaultProperty.instance.spacing.sideMargins * 5
                                  + DefaultProperty.instance.sizes.logoDisplaySize
                                  + DefaultProperty.instance.sizes.registerHeight),
                          
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            padding: EdgeInsets.all(40),
                            child: Material(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EmailUserForm(placeholder: "Email", action: () {

                                  },),
                                  SizedBox(
                                    width: double.infinity,
                                    child: SubmitUserForm(text: "Get new Pass", action: () {

                                    },backgroundColor: DefaultProperty.instance.colors.mainIndigo,
                                      foregroundColor: Colors.white,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    );
                  },
                  child: TextWidget(
                    text: "Forgot Password?",
                    family: "Avenir",
                    color: Colors.grey,
                    size: 12,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: userForms.last
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
                  height: DefaultProperty.instance.spacing.sideMargins*2 +
                      DefaultProperty.instance.sizes.navigationHeight
              )
            ],
          ),
        ],
      )
    );
  }
}
