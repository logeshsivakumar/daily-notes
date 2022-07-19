import 'package:dailynotes/customwidgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/loginprovider.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email=TextEditingController();
  final resetPasswordKey = GlobalKey<FormState>();
  bool validateForm(){
    if(resetPasswordKey.currentState!.validate()){
      print(email.text);
      return true;
    }else{
      print("unsucessfull");
      return false;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF3F3D56) ,
      appBar: AppBar(
        backgroundColor:const Color(0xFF3F3D56) ,
        title: const Text("Reset password"),
      ),
      body: Center(
        child: Form(
          key:resetPasswordKey ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text("Receive an email to reset your password",  style:GoogleFonts.lato(
                fontSize: 14.sp,
                color: Colors.white,
              ),
              ),
              SizedBox(
                height: 15.h,
              ),
              InputFieldsC(
                  getIcon:const Icon(Icons.email,color:Color(0xFF3F3D56),) ,
                  textEditingController: email,
                  letterSize: 18.sp,
                  cursorColor: const Color(0xFF3F3D56),
                  obscureText: false,
                  validators: [
                    RequiredValidator(errorText: "Required"),
                    EmailValidator(
                        errorText: "Enter the valid email address"
                    )
                  ],
                  hintText: "Email",
                  inputType: TextInputType.text),
              ElevatedButton(
                  onPressed: (){
                    if(validateForm()==true){
                      Provider.of<LoginProvider>(context,listen: false).resetPassword(email.text.trim(),context);
                    }
                  }, child: const Text("Reset Password"),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.teal),padding:MaterialStateProperty.all(EdgeInsets.only(left: 50.w,right: 50.w))  ),)
            ],
          ),
        ),
      ),
    );
  }
}
