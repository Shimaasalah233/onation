import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:ONATION/loginandregisteration/forgetpasschange.dart';
import 'package:ONATION/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangpassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Changpass(),
    );
  }
}

class Changpass extends StatefulWidget {
  @override
  _Changpass createState() => _Changpass();
}

class _Changpass extends State<Changpass> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
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
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
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
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is PassUpdateSuccess) {
        // Navigate to the new page

        // Show SnackBar after navigation

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Text(
                state.message,
                style: TextStyle(color: Color(0xff4FACD7), fontSize: 18.0),
              ),
              alignment: Alignment.center,
              height: 50,
            ),
            backgroundColor: Color(0xffffffff),
            // Adjust width in landscape
          ),
        );
        Future.delayed(Duration(milliseconds: 600), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Setting()),
          );
        });
      } else if (state is PassUpdateFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              child: Text(
                "فشل تغيير كلمة السر",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              alignment: Alignment.center,
              height: 50,
            ),
            backgroundColor: Color(0xffe73131),
            // Adjust width in landscape
          ),
        );
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
                                        builder: (context) => Setting()),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  'images/reset-password.png',
                                  /* fit: BoxFit.cover,*/
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Text(' كلمة السر الحالية',
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
                                    MediaQuery.of(context).size.width * 0.02,
                                    0,
                                    MediaQuery.of(context).size.width * 0.02,
                                    0),
                                child: TextFormField(
                                  controller: _currentPasswordController,
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    if (_currentPasswordController
                                        .text.isEmpty) {
                                      return 'من فضلك ادخل كلمة السر الاصلية';
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
                                      borderRadius: BorderRadius.circular(30.0),
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
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                    MediaQuery.of(context).size.width * 0.02,
                                    0,
                                    MediaQuery.of(context).size.width * 0.02,
                                    0),
                                child: TextFormField(
                                  controller: _newPasswordController,
                                  obscureText: _obscureText2,
                                  validator: (value) {
                                    if (_newPasswordController.text.isEmpty) {
                                      return 'من فضلك ادخل كلمة السر الجديدة ';
                                    }
                                    if (_newPasswordController.text.length <
                                        8) {
                                      return error;
                                    }

                                    // Add your own additional criteria for strong password validation
                                    if (!_containsSpecialCharacter(
                                        _newPasswordController.text)) {
                                      return error;
                                    }
                                    if (!_containsNumber(
                                        _newPasswordController.text)) {
                                      return error;
                                    }
                                    if (!_containsUppercase(
                                        _newPasswordController.text)) {
                                      return error;
                                    }
                                    if (!_containsLowercase(
                                        _newPasswordController.text)) {
                                      return error;
                                    }
                                    return null;
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
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 15.0),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Forgetpasswordchange()),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Color(0xff4FACD7), // Text color
                                          side: BorderSide.none,
                                          // Border color
                                          padding: EdgeInsets.fromLTRB(
                                              10, 20, 5, 20), // Button padding
                                        ),
                                        child: Text(
                                          ' هل نسيت كلمة السر؟',
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Container(
                                    child: OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final currentPassword =
                                          _currentPasswordController.text;
                                      final newPassword =
                                          _newPasswordController.text;
                                      context.read<AuthCubit>().changePassword(
                                          currentPassword, newPassword);
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    backgroundColor: Color(0xffffffff),
                                    // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color:
                                              Colors.blue), // Rounded corners
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
                                    'تغيير كلمة السر',
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
                                          builder: (context) => Setting()),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    height: MediaQuery.of(context).size.height *
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
                                      child: Text('كلمة السر الحالية',
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
                                      MediaQuery.of(context).size.width * 0.02,
                                      0,
                                      MediaQuery.of(context).size.width * 0.02,
                                      0),
                                  child: TextFormField(
                                    controller: _currentPasswordController,
                                    obscureText: _obscureText,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك ادخل كلمة السر الحالية';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      pass = value;
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
                                      MediaQuery.of(context).size.width * 0.02,
                                      0,
                                      MediaQuery.of(context).size.width * 0.02,
                                      0),
                                  child: TextFormField(
                                    controller: _newPasswordController,
                                    obscureText: _obscureText2,
                                    validator: (value) {
                                      if (_newPasswordController.text.isEmpty) {
                                        return 'من فضلك ادخل كلمة السر الجديدة ';
                                      }
                                      if (_newPasswordController.text.length <
                                          8) {
                                        return error;
                                      }

                                      // Add your own additional criteria for strong password validation
                                      if (!_containsSpecialCharacter(
                                          _newPasswordController.text)) {
                                        return error;
                                      }
                                      if (!_containsNumber(
                                          _newPasswordController.text)) {
                                        return error;
                                      }
                                      if (!_containsUppercase(
                                          _newPasswordController.text)) {
                                        return error;
                                      }
                                      if (!_containsLowercase(
                                          _newPasswordController.text)) {
                                        return error;
                                      }
                                      return null;
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
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Forgetpasswordchange()),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                Color(0xff4FACD7), // Text color
                                            side: BorderSide.none,
                                            // Border color
                                            padding: EdgeInsets.fromLTRB(10, 20,
                                                5, 20), // Button padding
                                          ),
                                          child: Text(
                                            ' هل نسيت كلمة السر؟',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Container(
                                      child: OutlinedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final currentPassword =
                                            _currentPasswordController.text;
                                        final newPassword =
                                            _newPasswordController.text;
                                        context
                                            .read<AuthCubit>()
                                            .changePassword(
                                                currentPassword, newPassword);
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shadowColor: Colors.white,
                                      backgroundColor: Color(0xffffffff),
                                      // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(
                                            color:
                                                Colors.blue), // Rounded corners
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
                                      'تغيير كلمة السر',
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
    });
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
