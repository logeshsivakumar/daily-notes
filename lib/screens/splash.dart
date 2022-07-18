import 'package:dailynotes/customwidgets/textformfield.dart';
import 'package:dailynotes/providers/loginprovider.dart';
import 'package:dailynotes/screens/forgetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final signInPage = GlobalKey<FormState>();
  final signUpPage = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController emailSignUP=TextEditingController();
  TextEditingController passwordSignUP=TextEditingController();
  TextEditingController passwordSignUPConfirm=TextEditingController();
  var keyboardVisibilityController = KeyboardVisibilityController();
  int _pageState = 0;
  Color _bgColor = Colors.white;
  Color _hdColor = Colors.black;

  double _headingTop = 100.h;
  double _loginHeight = 0.h;
  double _registerHeight = 0.h;
  double _loginWidth = 0.w;
  double _loginOpacity = 1.w;

  double _loginXOffset = 0.sp;
  double _loginYOffset = 0.sp;
  double _registerYOffset = 0.sp;

  double windowWidth = 0.w;
  double windowHeight = 0.h;

  bool _keyboardVisible = false;
  bool _passwordVisibleSignIn= true;
  bool _passwordVisibleSignUp= true;
  bool _passwordVisibleSignUpConfirm= true;
  String? signUpPassword;
  String? confirmPassword;
  @override
  void initState() {
    super.initState();
    _passwordVisibleSignIn=true;
    _passwordVisibleSignUp=true;
    _passwordVisibleSignUpConfirm=true;
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!mounted) return;
      setState(() {
        _keyboardVisible = visible;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    emailSignUP.dispose();
    passwordSignUP.dispose();
    passwordSignUPConfirm.dispose();
  }
  bool validateForm(){
    if(signInPage.currentState!.validate()){
      print(email.text);
      print(password.text);
      return true;
    }else{
     print("unsucessfull");
     return false;
    }
  }
  bool validateSignUpForm(){
    if(signUpPage.currentState!.validate()){
      print(emailSignUP.text);
      print(passwordSignUPConfirm.text);
      print(signUpPassword);
      return true;
    }else{
      print("unsucessfull");
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270.h;
    _registerHeight = windowHeight - 270.h;

    switch (_pageState) {
      case 0:
        _bgColor = Colors.white;
        _hdColor = Colors.black;

        _headingTop = 100.h;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginXOffset = 0;
        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270.h;
        _registerYOffset = windowHeight;

        break;
      case 1:
        _bgColor = const Color(0xFF3F3D56);
        _hdColor = Colors.white;

        _headingTop = 90.h;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginXOffset = 0;
        _loginYOffset = _keyboardVisible ? 40.sp : 270.sp;

        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270.h;

        _registerYOffset = windowHeight;
        break;
      case 2:
        _bgColor = const Color(0xFF3F3D56);
        _hdColor = Colors.white;

        _headingTop = 80.h;

        _loginWidth = windowWidth - 40.w;
        _loginOpacity = 0.7.sp;

        _loginXOffset = 20.sp;
        _loginYOffset = _keyboardVisible ? 30.sp : 240.sp;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 250.h;
        _registerYOffset = _keyboardVisible ? 50.sp : 270.sp;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270.h;
        break;
    }
    return Scaffold(
      body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState((){
                  _pageState = 0;
                });
              },
              child:AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 5000),
                color: _bgColor,
                child: AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1000),
                  margin: EdgeInsets.only(top: _headingTop),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom: 50.sp),
                          child: ListTile(
                            title:  Align(
                              alignment: Alignment.center,
                              child: Text(
                                   "Daily Notes",
                                   style:GoogleFonts.lato(
                                     fontSize: 30.sp,
                                     color: _hdColor,
                                   ),),
                            ),
                            subtitle:   Text(
                             "Keep your daily notes",
                             textAlign: TextAlign.center,
                             style:GoogleFonts.lato(
                               fontSize: 14.sp,
                               color: _hdColor,
                             ) ,
                          ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 50.sp),
                          child: Center(
                            child: Image.asset("assets/images/splashnotes.png"),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 70.sp),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_pageState != 0) {
                                  _pageState = 0;
                                } else {
                                  _pageState = 1;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(40.sp),
                              padding: EdgeInsets.all(20.sp),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF3F3D56),
                                  borderRadius: BorderRadius.circular(55.sp)),
                              child: Center(
                                child: Text(
                                    "Get Started",
                                    style:GoogleFonts.lato(
                                      fontSize: 16.sp,
                                      color: _bgColor,
                                    )
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              padding: EdgeInsets.all(20.sp),
              width: _loginWidth,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_loginOpacity),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.sp),
                    topRight: Radius.circular(25.sp),
                  )),
              child: Form(
                key:signInPage,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18.h),
                      child: Text(
                        "Login To Continue",
                          style:GoogleFonts.lato(
                            fontSize: 26.sp,
                            color: const Color(0xFF3F3D56),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    InputFieldsC(
                        getIcon:const Icon(Icons.password,color:Color(0xFF3F3D56),) ,
                        getPasswordIcon: IconButton(onPressed: (){
                          setState((){
                            if(_passwordVisibleSignIn==true){
                              _passwordVisibleSignIn=false;
                            }else{
                              _passwordVisibleSignIn=true;
                            }
                          });
                        }, icon: Icon(
                          _passwordVisibleSignIn==true?Icons.visibility_off:Icons.visibility,color:const Color(0xFF3F3D56),
                        ),
                        ),
                        textEditingController: password,
                        letterSize: 18.sp,
                        cursorColor: const Color(0xFF3F3D56),
                        obscureText:_passwordVisibleSignIn,
                        validators: [
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(8,
                              errorText: "Password should be min 8 characters",
                          ),
                          PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              errorText: 'passwords must have special character,UpperCase and a digit ')
                        ],
                        hintText: "Password",
                        inputType: TextInputType.text),
                    InkWell(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ForgetPassword()));
                        },
                    child: const Text("Forget Password?",style:TextStyle(color: Color(0xFF3F3D56),decoration: TextDecoration.underline),)),
                    SizedBox(
                      height: 10.h,
                    ),
                  InkWell(
                          onTap: (){
                          if(validateForm()==true){
                             Provider.of<LoginProvider>(context,listen: false).signIn(email.text.trim(), password.text.trim(),context);
                          }
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xFF3F3D56),
                                borderRadius: BorderRadius.circular(55.sp)),
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.lato(
                                  fontSize: 16.sp,
                                  color: _hdColor,
                                )
                              ),
                            ),
                          ),
                        ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF3F3D56),
                          ),
                          borderRadius: BorderRadius.circular(55.sp)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageState = 2;
                            });
                          },
                          child: Text(
                            "Create new Account",
                            style: GoogleFonts.lato(
                              fontSize: 16.sp,
                              color: _bgColor,
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _registerYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.sp),
                      topRight: Radius.circular(25.sp))),
              child: Form(
                key:signUpPage,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18.h),
                      child: Text(
                        "Create new Account",
                        style: GoogleFonts.lato(
                          fontSize: 26.sp,
                          color: const Color(0xFF3F3D56),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InputFieldsC(
                        getIcon:const Icon(Icons.email,color:Color(0xFF3F3D56),) ,
                        textEditingController: emailSignUP,
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
                    SizedBox(
                      height: 15.h,
                    ),
                    InputFieldsC(
                        getIcon:const Icon(Icons.password,color:Color(0xFF3F3D56),) ,
                        onCallBack: (val){
                          signUpPassword!=val;
                        },
                        getPasswordIcon: IconButton(onPressed: (){
                          setState((){
                            if(_passwordVisibleSignUp==false){
                              _passwordVisibleSignUp=true;
                            }else{
                              _passwordVisibleSignUp=false;
                            }
                          });
                        },
                          icon: Icon(
                          _passwordVisibleSignUp==true?Icons.visibility_off:Icons.visibility,color:const Color(0xFF3F3D56),
                        ),
                        ),
                        textEditingController: passwordSignUP,
                        letterSize: 18.sp,
                        cursorColor: const Color(0xFF3F3D56),
                        obscureText:_passwordVisibleSignUp,
                        validators: [
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(8,
                            errorText: "Password should be min 8 characters",
                          ),
                          PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              errorText: 'passwords must have special character,UpperCase and a digit ')
                        ],
                        hintText: "Password",
                        inputType: TextInputType.text),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 25.sp, left: 25.sp,),
                      child: TextFormField(
                        controller: passwordSignUPConfirm,
                        obscureText:_passwordVisibleSignUpConfirm ,
                        textAlign: TextAlign.left,
                        cursorColor: const Color(0xFF3F3D56),
                        validator: (val){
                             if(val!.isEmpty) {
                               return 'Empty';
                             } else if(val!= passwordSignUP.text){
                               return 'Password not matching';
                             }
                            return null;
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18.sp),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                            setState((){
                              if(_passwordVisibleSignUpConfirm==false){
                                _passwordVisibleSignUpConfirm=true;
                              }else{
                                _passwordVisibleSignUpConfirm=false;
                              }
                            });

                          }, icon:Icon(
                            _passwordVisibleSignUpConfirm==true?Icons.visibility_off:Icons.visibility,color:const Color(0xFF3F3D56),
                          ),),
                          prefixIcon:const Icon(Icons.password,color:Color(0xFF3F3D56),),
                          prefixIconColor:const Color(0xFF3F3D56) ,
                          errorStyle: const TextStyle(
                              fontSize: 18 - 2,
                              color: Colors.redAccent),
                          hintText: "Confirm password",
                          errorMaxLines:2,
                          counterText: "",
                          hintStyle:GoogleFonts.lato(
                            color: const Color(0xFF3F3D56),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                            borderSide: const BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                                color: const Color(0xFF3F3D56), width: 2.w),
                          ),
                          contentPadding: EdgeInsets.all(12.sp),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w,right:15.w),
                      padding: EdgeInsets.all(20.sp),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFF3F3D56),
                          borderRadius: BorderRadius.circular(55.sp)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if(validateSignUpForm()==true){
                              Provider.of<LoginProvider>(context,listen: false).signUp(emailSignUP.text.trim(), passwordSignUPConfirm.text.trim(),context);
                            }
                          },
                          child: Text(
                            "Create new Account",
                            style:GoogleFonts.lato(
                              fontSize: 18.sp,
                              color: _hdColor,
                            )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w,right:15.w),
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF3F3D56),
                          ),
                          borderRadius: BorderRadius.circular(55.sp)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageState = 1;
                            });
                          },
                          child: Text(
                            "Back to Login",
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              color: const Color(0xFF3F3D56),
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}


