import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Const_TextFormField extends StatelessWidget {
   final String? hintname;
   final String? returnName;
    final TextInputType?  widgets;
  final TextEditingController? nameController;

  Const_TextFormField({this.hintname,this.returnName,this.widgets,this.nameController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
        ],

        controller: nameController!,
        keyboardType:widgets,
        validator: (value) {
          if(widgets==TextInputType.phone){
            if (value!.isEmpty ) {
              return returnName;
            }else if((value.length<11 || value.length>15)){
              return "phone number must be more than 11 and less than 15";

            }
            else {
              return null;
            }

          }else{
            if (value!.isEmpty) {
              return returnName;
            }
            else {
              return null;
            }

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
          hintText: (hintname),
        ),
      ),
    )
    ;
  }
}
