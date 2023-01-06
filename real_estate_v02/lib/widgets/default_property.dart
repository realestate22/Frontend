import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultProperty{
   static DefaultProperty? _defaultProperty;
   static DefaultProperty get instance =>
       _defaultProperty ??= DefaultProperty._private();

   late DefaultSpacing spacing;
   late DefaultSizes sizes;
   late DefaultLimits limits;
   late DefaultColors colors;
   late DefaultImages images;
   late DefaultStrings strings;

   DefaultProperty._private(){
      log("initProperty");
      spacing=DefaultSpacing.instance;
      sizes=DefaultSizes.instance;
      limits=DefaultLimits.instance;
      colors=DefaultColors.instance;
      images=DefaultImages.instance;
      strings=DefaultStrings.instance;
   }
}

class DefaultStrings{
   static DefaultStrings? _defaultStrings;
   static DefaultStrings get instance =>
       _defaultStrings ??= DefaultStrings._private();

   late final String serverLink;
   late final String imagesServerLink;
   late final String videosServerLink;
   late final String allowedCharsForFiles;
   late final String allowedCharsForMail;
   late final Map<String, List<String>> extensions;

   DefaultStrings._private(){
      log("initStrings");
      serverLink="http://192.168.1.7:8000/";
      imagesServerLink="assets/images/";
      videosServerLink="assets/videos/";
      allowedCharsForFiles=
         "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      extensions={
         "images": ["jpeg","jpg","png","gif","ico"],
         "videos": ["mp4","mov"]
      };
      allowedCharsForMail="[a-zA-Z0-9!#\$%^&*+\\-/_=?{|}~]";
   }

   String getTypeFromExtension(String? input){
      return extensions.entries.firstWhere(
         (element) => element.value.contains(input),
         orElse: () => const MapEntry<String, List<String>>("other", [])
      ).key;
   }
   String? getExtensionsFromList(String input){
      String res = extensions.values.expand((element) => element).
         firstWhere((element) => input.contains(element),orElse: () => "___");
      return res=="___"?null:res;
   }
}

class DefaultSpacing{
   static DefaultSpacing? _defaultSpacing;
   static DefaultSpacing get instance =>
       _defaultSpacing ??= DefaultSpacing._private();

   late final double sideMargins;
   late final double spaceBetween;
   late final double borderRadius;
   late final double sideTextPadding;
   late final double inputBorderRadius;
   late final double buttonBorderRadius;
   late final double defaultPaddingInputSize;
   late final double letterSpacingToCenter;

   DefaultSpacing._private(){
      log("initSpacing");
      sideMargins = 20;
      spaceBetween = 10;
      borderRadius = 15;
      sideTextPadding = 5;
      inputBorderRadius = 5;
      buttonBorderRadius = 30;
      defaultPaddingInputSize = 14;
      letterSpacingToCenter = 1.5;
   }

}

class DefaultSizes{
   static DefaultSizes? _defaultSizes;
   static DefaultSizes get instance =>
       _defaultSizes ??= DefaultSizes._private();

   late final double navigationHeight;
   late final double searchHeight;
   late final double itemWidgetHeight ;
   late final double itemViewHeight;
   late final double itemViewDetailedHeight;
   late final double indexViewSize;
   late final double locationButtonSize;
   late final double mapDetailedHeight;
   late final double logoDisplaySize;
   late final double registerHeight;
   late final double borderSize;
   late final double defaultFontSize;

   DefaultSizes._private(){
      log("initSizes");
      navigationHeight = 60;
      searchHeight = 40;
      itemWidgetHeight = 275;
      itemViewDetailedHeight= 500;
      itemViewHeight = 150;
      indexViewSize = 6;
      locationButtonSize = 50;
      mapDetailedHeight = 100;
      logoDisplaySize = 100;
      registerHeight = 40;
      borderSize = 2;
      defaultFontSize = 16;
   }
}

class DefaultLimits{
   static DefaultLimits? _defaultLimits;
   static DefaultLimits get instance =>
       _defaultLimits ??= DefaultLimits._private();


   late final int featuresCap;

   DefaultLimits._private(){
      log("initLimits");
      featuresCap = 5;
   }

}

class DefaultColors{
   static DefaultColors? _defaultColors;
   static DefaultColors get instance =>
       _defaultColors ??= DefaultColors._private();

   late final Color backgroundColor;
   late final Color mainIndigo;
   late final Color lighterMainIndigo;
   late final Color redContrast;
   late final Color blurColor;
   late final Color blackTransparent;
   late final Color mainText;
   late final Color secondaryText;
   late final Color lightColor;

   DefaultColors._private(){
      log("initColors");
      backgroundColor= const Color.fromARGB(255, 212, 228, 236);
      mainIndigo=const Color.fromARGB(255,70,100,200);
      lighterMainIndigo=const Color.fromARGB(127,70,100,200);
      redContrast=const Color.fromARGB(255, 255, 90, 110);
      blurColor=const Color.fromARGB(100, 200, 200, 200);
      blackTransparent=const Color.fromARGB(127, 0, 0, 0);
      mainText=const Color.fromARGB(255, 5, 5, 5);
      secondaryText=const Color.fromARGB(255, 120, 120, 120);
      lightColor= const Color.fromARGB(255, 250, 250, 250);
   }
}

class DefaultImages{
   static DefaultImages? _defaultImages;
   static DefaultImages get instance =>
       _defaultImages ??= DefaultImages._private();

   late final Image logoWhite;
   late final Image logoBlack;
   late final SvgPicture googleIcon;

   DefaultImages._private(){
      log("initImages");
      logoWhite=Image.asset("assets/images/logo_white.png");
      logoBlack=Image.asset("assets/images/logo_white.png");
      googleIcon=SvgPicture.asset("assets/images/google_icon.svg");
   }


}
