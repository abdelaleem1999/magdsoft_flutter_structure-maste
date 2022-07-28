import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_state.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/main.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/login/login_view.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/navigation_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/text_form_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/translation_button.dart';

class RegisterView extends StatefulWidget {

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _Passcontroller = TextEditingController();
  TextEditingController _ConfirmPasscontroller = TextEditingController();
  TextEditingController _Namecontroller = TextEditingController();
  TextEditingController _Phonecontroller = TextEditingController();
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/4,
            child: ClipRRect(

              borderRadius: BorderRadius.circular(0), // Image border

              child: Image.asset("assets/images/logo (1).png",
              ),
            ),

          ),

          Container(

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only( topRight: Radius.circular(45),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  topLeft: Radius.circular(45)),
            ),

            child: Padding(
              padding: const EdgeInsets.only(left: 50.0,right: 50,top: 30,bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Const_TextFormField(
                          hintname:translate("RegisterView.name") ,
                          nameController:_Namecontroller ,
                          returnName: translate("RegisterView.name_validation"),
                          widgets: TextInputType.name,
                        ),
                        Const_TextFormField(
                          hintname:translate("RegisterView.email") ,
                          nameController:_Emailcontroller ,
                          returnName:translate("RegisterView.email_validation"),
                          widgets: TextInputType.emailAddress,
                        ),
                        Const_TextFormField(
                          hintname:translate("RegisterView.phone") ,
                          nameController:_Phonecontroller ,
                          returnName: translate("RegisterView.phone_validation"),
                          widgets: TextInputType.phone,
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
                                return translate("RegisterView.pass_validation");
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
                              hintText: translate("RegisterView.pass"),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                            ],

                            controller: _ConfirmPasscontroller,
                            validator: (value) {
                              if (value != _Passcontroller.text) {
                                return 'Password is not the same';
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
                              hintText: translate("RegisterView.confirm_pass"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      BlocBuilder(
                        bloc: RegisterCubit.of(context),
                        builder: (context, state) =>state is SignUpLoading
                            ?  Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: CircularProgressIndicator(),
                        )



                            : InkWell(

                          onTap: () async {
                            if (!formKey.currentState!.validate()) return;
                            try{
                              final message = await RegisterCubit.of(context)
                                  .signUp(_Emailcontroller.text,_Passcontroller.text,
                                  _Namecontroller.text,_Phonecontroller.text);
                              if ( message != 'ok') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(message!)));
                              } else {
                                CacheHelper.saveDataSharedPreference(key: 'name', value: _Namecontroller.text);
                                CacheHelper.saveDataSharedPreference(key: 'email', value: _Emailcontroller.text);
                                CacheHelper.saveDataSharedPreference(key: 'phone', value:_Phonecontroller.text);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserProfile(),

                                    ));





                              }
                            }catch(e,s){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('email not permission ')));
                            }

                          },
                          child:  NavigationButton(
                            Button_name: translate("RegisterView.Register_button"),
                            color: AppColor.blue,
                          ),

                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView()));
                        },
                        child: NavigationButton(
                          Button_name: translate("RegisterView.login_button"),
                          color: AppColor.blue,
                        ),
                      ),


                    ],
                  ),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
