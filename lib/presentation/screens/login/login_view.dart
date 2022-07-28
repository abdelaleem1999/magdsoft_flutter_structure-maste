import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_state.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/main.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/register/register_view.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/navigation_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/translation_button.dart';

class LoginView extends StatefulWidget {

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _Passcontroller = TextEditingController();
  bool isPasswordShow = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue,
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              children: [

                Container(
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(0), // Image border

                    child: Image.asset("assets/images/logo (1).png",
                        fit: BoxFit.fitHeight),
                  ),

                ),
                Expanded(
                  flex: 2,
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only( topRight: Radius.circular(45),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(45)),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 50.0,right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                  ],

                                  controller: _Emailcontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return translate("LoginView.email_validation");
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                  textAlign: TextAlign.left,

                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                    fillColor: Colors.white, filled: true,
                                    border: new OutlineInputBorder(

                                      borderRadius: new BorderRadius.circular(9.0),
                                      borderSide: new BorderSide(),

                                    ),


                                    hintStyle: TextStyle(color: Colors.black26),
                                    hintText: (translate("LoginView.email")),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  height: 70,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                                    ],

                                    controller: _Passcontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return translate("LoginView.pass_validation");
                                      } else {
                                        return null;
                                      }
                                    },
                                    textAlign: TextAlign.left,
                                    obscureText: isPasswordShow,

                                    decoration: InputDecoration(
                                      contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                      fillColor: Colors.white, filled: true,

                                      border: new OutlineInputBorder(

                                        borderRadius: new BorderRadius.circular(9.0),
                                        borderSide: new BorderSide(

                                        ),
                                      ),

                                      suffixIcon: IconButton(
                                        icon: isPasswordShow
                                            ? Icon(Icons.visibility_sharp,)
                                            : Icon(Icons.visibility_off,),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordShow = !isPasswordShow;
                                          });
                                        },
                                      ),


                                      hintStyle: TextStyle(color: Colors.black26),
                                      hintText: (translate("LoginView.pass")),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterView()));
                                },
                                child: NavigationButton(
                                  Button_name:translate("LoginView.Register_button"),
                                  color:AppColor.blue,
                                ),
                              ),

                              BlocBuilder(
                                bloc: LoginCubits.of(context),
                                builder: (context, state) =>state is loodinglLogin
                                    ?  Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: CircularProgressIndicator(),
                                    )




                                    : InkWell(

                                  onTap: () async {
                                    if (!formKey.currentState!.validate()) return;
                                    try{
                                      final message = await LoginCubits.of(context)
                                          .login(_Emailcontroller.text,_Passcontroller.text);
                                      if ( message != 'ok') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text(message!)));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserProfile(),

                                            ));





                                      }
                                      // final response=await FirebaseFirestore.instance
                                      //     .collection('users').doc(_Emailcontroller.text).get();
                                      //
                                    }catch(e,s){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('car not permission ')));
                                    }

                                  },
                                  child: NavigationButton(
                                    Button_name: translate("LoginView.login_button"),
                                    color: AppColor.blue,
                                  ),

                                ),
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            InkWell(
              onTap: ()async{
                if( CacheHelper.getDataFromSharedPreference(key: "language")=='ar'){
                  await delegate.changeLocale(Locale('en'));
                  CacheHelper.saveDataSharedPreference(key: 'language', value: 'en');

                }else{
                  await delegate.changeLocale(Locale('ar'));
                  CacheHelper.saveDataSharedPreference(key: 'language', value: 'ar');
                }

              },
              child: Translation_Button(
                Button_name: translate("LoginView.traslation"),
              ),
            )

          ],
        )
      );
  }
}
