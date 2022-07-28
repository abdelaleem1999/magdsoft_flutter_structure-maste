import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/login/login_view.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/navigation_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/user_data_text.dart';

class UserProfile extends StatefulWidget {

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.blue,
        title: Center(
          child:Text("User Data") ,
        ),
      ),
      body:CacheHelper.getDataFromSharedPreference(key: 'email')==null
          ?Center(child: CircularProgressIndicator())
       :  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserDataText(
              Key: translate("User_profile.name"),
              value: CacheHelper.getDataFromSharedPreference(key: 'name'),
            ),
            UserDataText(
              Key: translate("User_profile.email"),
              value: CacheHelper.getDataFromSharedPreference(key: 'email'),
            ),
            UserDataText(
              Key: translate("User_profile.phone"),
              value: CacheHelper.getDataFromSharedPreference(key: 'phone'),
            ),
            SizedBox(height: 300,),
            InkWell(
              onTap: (){
                CacheHelper.clearData();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));
              },
              child: NavigationButton(
                Button_name:  translate("User_profile.logOut"),
                color: AppColor.red,
              ),
            )


          ],
        ),

    );
  }
}
