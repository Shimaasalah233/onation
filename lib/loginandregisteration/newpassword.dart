import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ONATION/loginandregisteration/code.dart';
import 'package:ONATION/loginandregisteration/haveaccount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newpassword extends StatefulWidget {
  @override
  _Newpassword createState() => _Newpassword();
}

class _Newpassword extends State<Newpassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String pass = '';
  String confirm_pass = '';
  bool _obscureText = true;
  bool _obscureText2 = true;

  bool _containsSpecialCharacter(String value) {
    final pattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return pattern.hasMatch(value);
  }

  bool _Number(String value) {
    final pattern = RegExp(r'[0-9]');
    return pattern.hasMatch(value);
  }

  bool _Upper(String value) {
    final pattern = RegExp(r'[A-Z]');
    return pattern.hasMatch(value);
  }

  bool _Lower(String value) {
    final pattern = RegExp(r'[a-z]');
    return pattern.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    String text1 = 'يجب ان تحتوي كلمة السر على الاقل:';
    String text2 = 'ثمانية حروف أو أرقام';
    String text3 = 'رمز مميز واحد';
    String text4 = 'حرف كبير واحد';
    String text5 = 'حرف صغير واحد';
    String error = text1 +
        '\n' +
        '\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t' +
        text2 +
        '\n' +
        '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t' +
        text3 +
        '\n' +
        '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t' +
        text4 +
        '\n' +
        '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t' +
        text5;
    return BlocProvider(
        create: (context) => AuthCubit(), // Replace with your Bloc
        child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is SuccesssresetState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                child: Text(
                  state.message,
                  style: TextStyle(color: Color(0xff4FACD7), fontSize: 18.0),
                ),
                alignment: Alignment.center,
                height: 50,
              ),
              backgroundColor: Colors.white,
            ));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HaveAccount()));
          } else if (state is FailedtoresetState) {
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
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > constraints.maxHeight) {
                  // Landscape orientation
                  return SingleChildScrollView(
                      child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Color(0xffffffff),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'images/whitelogo.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  Container(
                                    width: 10,
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
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Code()),
                                      );
                                    },
                                    icon: Icon(Icons.arrow_back,
                                        textDirection: TextDirection.rtl),
                                    color: Color(0xff87cff1), // Icon color
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 2,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.0625),
                          color: Color(0xff4FACD7),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.01875,
                                MediaQuery.of(context).size.height * 0.02125,
                                MediaQuery.of(context).size.width * 0.01875,
                                MediaQuery.of(context).size.height * 0.0225),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.28,
                                      'images/reset-password.png',
                                      /* fit: BoxFit.cover,*/
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Text('  كلمة السر الجديدة',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                        0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscureText,
                                      validator: (value) {
                                        if (_passwordController.text.isEmpty) {
                                          return 'من فضلك ادخل كلمة السر';
                                        }
                                        if (_passwordController.text.length <
                                            8) {
                                          return error;
                                        }

                                        // Add your own additional criteria for strong password validation
                                        if (!_containsSpecialCharacter(
                                            _passwordController.text)) {
                                          return error;
                                        }
                                        if (!_containsNumber(
                                            _passwordController.text)) {
                                          return error;
                                        }
                                        if (!_containsUppercase(
                                            _passwordController.text)) {
                                          return error;
                                        }
                                        if (!_containsLowercase(
                                            _passwordController.text)) {
                                          return error;
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                        hintTextDirection: TextDirection.rtl,
                                        filled: true,
                                        fillColor: Color(0xfff8f8f8),
                                        prefixIcon: Icon(Icons.lock_outline),
                                        prefixIconColor: Color(0xff87cff1),
                                        suffixIconColor: Color(0xff87cff1),
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Text('تأكيد كلمة السر الجديدة',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                        0,
                                        MediaQuery.of(context).size.width *
                                            0.02,
                                        0),
                                    child: TextFormField(
                                      controller: _confirmpasswordController,
                                      obscureText: _obscureText2,
                                      validator: (value) {
                                        if (_confirmpasswordController
                                            .text.isEmpty) {
                                          return 'من فضلك اكد كلمة السر  ';
                                        }
                                        if (_confirmpasswordController.text !=
                                            _passwordController.text) {
                                          return 'من فضلك تأكد ان هذه الكلمة تتطابق مع كلمة السر  ';
                                        }
                                        if (_confirmpasswordController.text ==
                                            _passwordController.text) {
                                          return null;
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          confirm_pass =
                                              _passwordController.text;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText2
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText2 = !_obscureText2;
                                            });
                                          },
                                        ),
                                        hintTextDirection: TextDirection.rtl,
                                        filled: true,
                                        fillColor: Color(0xfff8f8f8),
                                        prefixIcon: Icon(Icons.lock_outline),
                                        prefixIconColor: Color(0xff87cff1),
                                        suffixIconColor: Color(0xff87cff1),
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Container(
                                        child: OutlinedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .resetpass(
                                                  password:
                                                      _passwordController.text,
                                                  confirmpassword:
                                                      _confirmpasswordController
                                                          .text);
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        shadowColor: Colors.white,
                                        backgroundColor: Color(0xffffffff),
                                        // Text color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                              color: Colors
                                                  .blue), // Rounded corners
                                        ),
                                        // Border color
                                        padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.1125,
                                          MediaQuery.of(context).size.height *
                                              0.01875,
                                          MediaQuery.of(context).size.width *
                                              0.1125,
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                        ), // Button padding
                                      ),
                                      child: Text(
                                        'تأكيد',
                                        style: TextStyle(
                                            color: Color(0xff4FACD7),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
                } else {
                  // Portrait orientation
                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Color(0xffffffff),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'images/whitelogo.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    Container(
                                      width: 10,
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
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Code()),
                                        );
                                      },
                                      icon: Icon(Icons.arrow_back,
                                          textDirection: TextDirection.rtl),
                                      color: Color(0xff87cff1), // Icon color
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 2,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1125),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0625),
                            color: Color(0xff4FACD7),
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.01875,
                                  MediaQuery.of(context).size.height * 0.02125,
                                  MediaQuery.of(context).size.width * 0.01875,
                                  MediaQuery.of(context).size.height * 0.0225),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.28,
                                        'images/reset-password.png',
                                        /* fit: BoxFit.cover,*/
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          child: Text(' كلمة السر الجديدة',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                          0,
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                          0),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscureText,
                                        validator: (value) {
                                          if (_passwordController
                                              .text.isEmpty) {
                                            return 'من فضلك ادخل كلمة السر';
                                          }
                                          if (_passwordController.text.length <
                                              8) {
                                            return error;
                                          }

                                          // Add your own additional criteria for strong password validation
                                          if (!_containsSpecialCharacter(
                                              _passwordController.text)) {
                                            return error;
                                          }
                                          if (!_containsNumber(
                                              _passwordController.text)) {
                                            return error;
                                          }
                                          if (!_containsUppercase(
                                              _passwordController.text)) {
                                            return error;
                                          }
                                          if (!_containsLowercase(
                                              _passwordController.text)) {
                                            return error;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                          hintTextDirection: TextDirection.rtl,
                                          filled: true,
                                          fillColor: Color(0xfff8f8f8),
                                          prefixIcon: Icon(Icons.lock_outline),
                                          prefixIconColor: Color(0xff87cff1),
                                          suffixIconColor: Color(0xff87cff1),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 15.0),
                                        ),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          child: Text('تأكيد كلمة السر الجديدة',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                          0,
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                          0),
                                      child: TextFormField(
                                        controller: _confirmpasswordController,
                                        obscureText: _obscureText2,
                                        validator: (value) {
                                          if (_confirmpasswordController
                                              .text.isEmpty) {
                                            return 'من فضلك اكد كلمة السر  ';
                                          }
                                          if (_confirmpasswordController.text !=
                                              _passwordController.text) {
                                            return 'من فضلك تأكد ان هذه الكلمة تتطابق مع كلمة السر  ';
                                          }
                                          if (_confirmpasswordController.text ==
                                              _passwordController.text) {
                                            return null;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            confirm_pass =
                                                _passwordController.text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText2
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText2 = !_obscureText2;
                                              });
                                            },
                                          ),
                                          hintTextDirection: TextDirection.rtl,
                                          filled: true,
                                          fillColor: Color(0xfff8f8f8),
                                          prefixIcon: Icon(Icons.lock_outline),
                                          prefixIconColor: Color(0xff87cff1),
                                          suffixIconColor: Color(0xff87cff1),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 15.0),
                                        ),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: Container(
                                          child: OutlinedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthCubit>(context)
                                                .resetpass(
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    confirmpassword:
                                                        _confirmpasswordController
                                                            .text);
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          shadowColor: Colors.white,
                                          backgroundColor: Color(0xffffffff),
                                          // Text color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Colors
                                                    .blue), // Rounded corners
                                          ),
                                          // Border color
                                          padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.1125,
                                            MediaQuery.of(context).size.height *
                                                0.01875,
                                            MediaQuery.of(context).size.width *
                                                0.1125,
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                          ), // Button padding
                                        ),
                                        child: Text(
                                          'تأكيد',
                                          style: TextStyle(
                                              color: Color(0xff4FACD7),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          );
        }));
  }
}

bool _containsSpecialCharacter(String value) {
  final pattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  return pattern.hasMatch(value);
}

bool _containsNumber(String value) {
  final pattern = RegExp(r'[0-9]');
  return pattern.hasMatch(value);
}

bool _containsUppercase(String value) {
  final pattern = RegExp(r'[A-Z]');
  return pattern.hasMatch(value);
}

bool _containsLowercase(String value) {
  final pattern = RegExp(r'[a-z]');
  return pattern.hasMatch(value);
}
