import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon_app/constant/constants.dart';
import 'package:pokemon_app/constant/ui_helper.dart';

class AppTitle extends StatelessWidget {
  AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pokeballImageUrl = 'images/pokeball.png';
    return SizedBox(
      height: UIHelper.getAppTitleWidgetHeight(),
      child: Stack(
        children: [
          Padding(
            padding: UIHelper
                .getDefaultPadding(), // bizimkinde 8 ise daha büyük değerde atıyorum 10 olsun.
            child: Align(
              child: Text(
                Constants.title,
                style: Constants.titleStyle(),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Align(
            child: Image.asset(
              pokeballImageUrl,
              width: ScreenUtil().orientation == Orientation.portrait
                  ? 0.2.sh
                  : 0.4.sw,
              height: 100.h,
              fit: BoxFit.fitWidth,
            ),
            alignment: Alignment.topRight,
          )
        ],
      ),
    );
  }
  
}
