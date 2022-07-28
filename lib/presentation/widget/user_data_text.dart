import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

class UserDataText extends StatelessWidget {
   String? Key;
   String? value;
  UserDataText({this.Key,this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: CacheHelper.getDataFromSharedPreference(key: "language")=='en'
     ? const EdgeInsets.only(left: 45.0)
      :const EdgeInsets.only(right: 45.0),
      child: Row(

        children: [
          Text(Key! + ": " ,
            style: TextStyle(
              color:  AppColor.blue,
              fontSize: 20,
            ),),

          Text(value!,
        style: TextStyle(
          color:  AppColor.blue,
          fontSize: 20,
        ),)
        ],
      ),
    );
  }
}
