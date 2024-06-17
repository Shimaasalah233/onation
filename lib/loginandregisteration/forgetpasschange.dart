import 'package:ONATION/changepass.dart';
import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/loginandregisteration/code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpasswordchange extends StatefulWidget {
  @override
  _Forgetpasswordchange createState() => _Forgetpasswordchange();
}

class _Forgetpasswordchange extends State<Forgetpasswordchange> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(_emailController) {
    // Basic email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthCubit(), // Replace with your AuthCubit
        child: Scaffold(
          body: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return _buildPortraitLayout();
              } else {
                return _buildLandscapeLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      // Handle state changes here
      if (state is SendEmailSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Code()),
        );
      } else if (state is FaliledtoSendEmailState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            alignment: Alignment.center,
            height: 50,
          ),
          backgroundColor: Colors.red,
        ));
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Color(0xffffffff),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.0125),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset('images/whitelogo.png',
                              width: screenWidth * 0.0375,
                              height: screenWidth * 0.0375),
                          width: screenWidth * 0.0625,
                        ),
                        const Text(
                          'O-NATION',
                          style: TextStyle(
                              color: Color(0xff87cff1),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.00375,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Changpass()),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            textDirection: TextDirection.rtl,
                          ),
                          color: Color(0xff4FACD7), // Icon color
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: screenWidth,
                height: screenHeight,
                margin: EdgeInsets.only(top: screenHeight * 0.1125),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      screenWidth * 0.0625), // Make it circular
                  color: Color(0xff4FACD7),
                ),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.01875,
                            screenHeight * 0.02125,
                            screenWidth * 0.01875,
                            screenHeight * 0.0225),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'images/reset-password.png',
                                    width: screenWidth * 0.28,
                                    height: screenHeight * 0.28,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: screenWidth * 0.02,
                                      ),
                                      child: Text(
                                          ' أدخل البريد الإلكتروني لإرسال رمز التحقق',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.055,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xfff8f8f8))),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.025),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (_emailController.text.isEmpty) {
                                      return 'من فضلك أدخل البريد الإلكتروني ';
                                    }
                                    if (!isValidEmail(value)) {
                                      return 'من فضلك أدخل البريد الإلكتروني صحيح';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    filled: true,
                                    fillColor: Color(0xfff8f8f8),
                                    prefixIcon: Icon(Icons.email),
                                    prefixIconColor: Color(0xff87cff1),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.0375),
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.0025,
                                ),
                                Center(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.08,
                                      ),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthCubit>(context)
                                                .sendemail(
                                              email: _emailController.text,
                                            );
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shadowColor: Colors.white,
                                          backgroundColor: Color(0xffffffff),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                screenWidth * 0.0625),
                                            side:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          padding: EdgeInsets.fromLTRB(
                                            screenWidth * 0.1125,
                                            screenHeight * 0.01875,
                                            screenWidth * 0.1125,
                                            screenHeight * 0.025,
                                          ),
                                        ),
                                        child: Text(
                                          'إرسال الرمز ',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.044,
                                              color: Color(0xff4FACD7),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01875,
                                ),
                              ],
                            )))))
          ],
        ),
      );
    });
  }

  Widget _buildLandscapeLayout() {
    // Add your landscape layout here
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is SendEmailSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Code()),
        );
      } else if (state is FaliledtoSendEmailState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
          child: Text(state.message),
          alignment: Alignment.center,
          height: 50,
        )));
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Color(0xffffffff),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.0125),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Image.asset('images/whitelogo.png',
                              width: screenWidth * 0.0375,
                              height: screenWidth * 0.0375),
                          width: screenWidth * 0.0625,
                        ),
                        const Text(
                          'O-NATION',
                          style: TextStyle(
                              color: Color(0xff87cff1),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.00375,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Changpass()),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            textDirection: TextDirection.rtl,
                          ),
                          color: Color(0xff4FACD7), // Icon color
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: screenWidth,
                height: screenHeight * 1.5,
                margin: EdgeInsets.only(top: screenHeight * 0.25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      screenWidth * 0.0625), // Make it circular
                  color: Color(0xff4FACD7),
                ),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * 0.01875,
                            screenHeight * 0.02125,
                            screenWidth * 0.01875,
                            screenHeight * 0.0225),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: screenHeight * 0.07),
                                    child: Image.asset(
                                      'images/reset-password.png',
                                      width: screenWidth * 0.28,
                                      height: screenHeight * 0.28,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: screenWidth * 0.01,
                                      ),
                                      child: Text(
                                          ' أدخل البريد الإلكتروني لإرسال رمز التحقق',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.033,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xfff8f8f8))),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.025),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (_emailController.text.isEmpty) {
                                      return 'من فضلك أدخل البريد الإلكتروني ';
                                    }
                                    if (!isValidEmail(value)) {
                                      return 'من فضلك أدخل البريد الإلكتروني صحيح';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    filled: true,
                                    fillColor: Color(0xfff8f8f8),
                                    prefixIcon: Icon(Icons.email),
                                    prefixIconColor: Color(0xff87cff1),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.0375),
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.0025,
                                ),
                                Center(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.08,
                                      ),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthCubit>(context)
                                                .sendemail(
                                              email: _emailController.text,
                                            );
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shadowColor: Colors.white,
                                          backgroundColor: Color(0xffffffff),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                screenWidth * 0.0625),
                                            side:
                                                BorderSide(color: Colors.blue),
                                          ),
                                          padding: EdgeInsets.fromLTRB(
                                            screenWidth * 0.1125,
                                            screenHeight * 0.01875,
                                            screenWidth * 0.1125,
                                            screenHeight * 0.025,
                                          ),
                                        ),
                                        child: Text(
                                          'إرسال الرمز ',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.022,
                                              color: Color(0xff4FACD7),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01875,
                                ),
                              ],
                            )))))
          ],
        ),
      );
    });
  }
}
