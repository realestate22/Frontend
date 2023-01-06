import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_v02/provider/home_filter_controller.dart';
import 'package:real_estate_v02/widgets/default_property.dart';
import 'package:real_estate_v02/widgets/post/search_user_form.dart';

import '../post/icon_change.dart';

class SearchBar extends StatefulWidget {

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController tec = TextEditingController();
  late SearchUserForm search;


  @override
  void initState() {
    search= SearchUserForm(
      iconChange: IconChange(
        shownData: Icons.search,
        shownColor: Colors.black,
        action: () {
          FocusScope.of(context).unfocus();
        },
      ),
      placeholder: "Search",
      action: (){
        FocusScope.of(context).unfocus();
      }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left:DefaultProperty.instance.spacing.sideMargins,
          right:DefaultProperty.instance.spacing.sideMargins,
          top: DefaultProperty.instance.spacing.sideMargins
      ),
      child: Consumer<HomeFilterController>(
        builder: (context, value, child) {
          search.action=(){
            FocusScope.of(context).unfocus();
            value.setPrompt(tec.text);
          };
          search.iconChange?.action=(){
            FocusScope.of(context).unfocus();
            value.setPrompt(tec.text);
          };
          return search;
        },
      ),
    );
  }
}
