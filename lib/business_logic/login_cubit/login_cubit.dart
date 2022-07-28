
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_state.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';

class LoginCubits extends Cubit<LoginState> {
  LoginCubits() : super(intialLogin());
 static LoginCubits of(context)=>  BlocProvider.of(context);

  Future <String?>login (String email ,String password)async{
    try{
    emit(loodinglLogin());

    final respose =await Dio().post(
        'https://magdsoft-internship.herokuapp.com/api/login',
        data: jsonEncode({'email':email , 'password': password,'returnSecureToken': true,}),
 options: Options(validateStatus: ((status) {
    return status! <500;
 }))
      );
      if(respose.statusCode!<500){
        final value =respose.data as Map;
        if(value.toString().contains('id')){
          CacheHelper.saveDataSharedPreference(key: 'name', value: value['account'][0]['name']);
          CacheHelper.saveDataSharedPreference(key: 'email', value: value['account'][0]['email']);
          CacheHelper.saveDataSharedPreference(key: 'phone', value: value['account'][0]['phone']);
          emit(intialLogin());

          return 'ok';
        }else if (value.toString().contains('INVALID_PASSWORD')){
          emit(intialLogin());
          return ' password is incorrect';

        } else if (value.toString().contains('user Not Found')) {
          emit(intialLogin());

          return translate("Login_cubit.user_not_exists");
        } else if (respose == null) {
          emit(intialLogin());

          // server not responding.
          return 'server not responding, try agin';
        }else {
          emit(intialLogin());
          print(value.toString().contains('id'));

          return 'poor conecction ,try agin';
        }
      }

    }catch (e,s){
      return e.toString();

    }
   return "ss";
 }

}
// Fota