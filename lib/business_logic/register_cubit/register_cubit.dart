import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_state.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';

class RegisterCubit extends Cubit<SignUpStates> {

  RegisterCubit() : super(SignUpIntial());
 static RegisterCubit of (context) =>BlocProvider.of(context);
   late final String? x;


  Future <String?> signUp(String email, String password ,String name, String phone )async{
    try {
    emit(SignUpLoading());
    final response= await Dio().post(
        'https://magdsoft-internship.herokuapp.com/api/register',
        data:jsonEncode({'email':email ,'password':password,'name':name,'phone':phone,
          'returnSecureToken': true,

        }),
        options: Options(validateStatus: (status) {
          return status! < 500;
        })
    );
    if (response.statusCode! < 500) {
      final data =response.data as Map;
      if (data.toString().contains('message')) {
        print(data);


        emit(SignUpIntial());
        return 'ok';
      } else if (data.toString().contains('Account Already Exist')) {
        emit(SignUpIntial());

        return 'Email already exists';
      } else if (data.toString().contains('WEAK_PASSWORD')) {
        emit(SignUpIntial());

        return 'The password is weak. Try to write a password that contains letters and numbers';
      } else {
        emit(SignUpIntial());

        return 'Email is wrong';
      }

    }
      // not found
     else if (response == null) {
      // server not responding.
      return 'sorry , try agin The server may be damaged';
    } else {
      emit(SignUpIntial());

      return 'sorry , try agin ';

      // some other error or might be CORS policy error. you can add your url in CORS policy.
    }





  } catch (e,s){
      emit(SignUpIntial());
      return 'No Internet' ;
    }

    }
}