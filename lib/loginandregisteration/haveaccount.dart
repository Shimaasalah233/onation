import 'package:ONATION/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/loginandregisteration/registerationway.dart';
import 'package:ONATION/loginandregisteration/forgetpassword.dart';
import 'package:ONATION/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ONATION/cubit/user_states.dart';

class HaveAccountpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: HaveAccount(),
    );
  }
}

class HaveAccount extends StatefulWidget {
  @override
  _HaveAccount createState() => _HaveAccount();
}

class _HaveAccount extends State<HaveAccount> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String pass = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Navigationbar(isDarkMode: isDarkMode)));
            } else if (state is FailedToLoginState) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text(
                          state.message,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > constraints.maxHeight) {
                    // Landscape orientation
                    return SafeArea(
                        child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Color(0xFF76DEFF),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/bluelogo.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      const Text(
                                        'O-NATION',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
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
                                      Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Registerationway()),
                                          );
                                        },
                                        icon: Icon(Icons.arrow_back,
                                            textDirection: TextDirection.rtl),
                                        color: Colors.white, // Icon color
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
                                top: MediaQuery.of(context).size.height * 0.28),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                            child: Text('اسم المستخدم',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff4FACD7))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                            0,
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                            0),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          validator: (value) {
                                            if (_usernameController
                                                .text.isEmpty) {
                                              return 'من فضلك ادخل الاسم';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _username = value!;
                                          },
                                          decoration: InputDecoration(
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            filled: true,
                                            fillColor: Color(0xfff8f8f8),
                                            prefixIcon:
                                                Icon(Icons.person_2_outlined),
                                            prefixIconColor: Color(0xff87cff1),
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
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
                                            child: Text('كلملة السر',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff4FACD7))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0),
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
                                            return null;
                                          },
                                          onSaved: (value) {
                                            pass = value!;
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
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            filled: true,
                                            fillColor: Color(0xfff8f8f8),
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            prefixIconColor: Color(0xff87cff1),
                                            suffixIconColor: Color(0xff87cff1),
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
                                          ),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
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
                                                            Forgetpassword()),
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Color(
                                                      0xffffffff), // Text color
                                                  side: BorderSide.none,
                                                  // Border color
                                                  padding: EdgeInsets.fromLTRB(
                                                      10,
                                                      20,
                                                      5,
                                                      20), // Button padding
                                                ),
                                                child: Text(
                                                  ' هل نسيت كلمة السر؟',
                                                  style: TextStyle(
                                                      color: Color(0xff4FACD7),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Container(
                                            child: OutlinedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .login(
                                                userName:
                                                    _usernameController.text,
                                                password:
                                                    _passwordController.text,
                                              );
                                            }
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shadowColor: Colors.lightBlue,

                                            backgroundColor:
                                                Color(0xFF76DEFF), // Text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: Colors
                                                      .blue), // Rounded corners
                                            ),
                                            // Border color
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                15,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                15), // Button padding
                                          ),
                                          child: Text(
                                            state is LoginLoadingState
                                                ? 'جاري التحميل ....'
                                                : ' تسجيل الدخول',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          Text(
                                            'او المواصلة ب',
                                            style: TextStyle(
                                              color: Color(0xff4FACD7),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                          child: Stack(
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              shadowColor: Colors.lightBlue,

                                              backgroundColor: Color(
                                                  0xffffffff), // Text color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                // Rounded corners
                                              ),
                                              side: BorderSide(
                                                  color: Colors.blue),
                                              // Border color
                                              padding: EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  15,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  15), // Button padding
                                            ),
                                            child: Text(
                                              ' حساب جوجل',
                                              style: TextStyle(
                                                  color: Color(0xff4FACD7),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
                  } else {
                    // Portrait orientation
                    return SafeArea(
                        child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Color(0xFF76DEFF),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/bluelogo.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Container(
                                        width: 10,
                                      ),
                                      const Text(
                                        'O-NATION',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
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
                                      Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Registerationway()),
                                          );
                                        },
                                        icon: Icon(Icons.arrow_back,
                                            textDirection: TextDirection.rtl),
                                        color: Colors.white, // Icon color
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.1),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                            child: Text('اسم المستخدم',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff4FACD7))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                            0,
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                            0),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          validator: (value) {
                                            if (_usernameController
                                                .text.isEmpty) {
                                              return 'من فضلك ادخل الاسم';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            filled: true,
                                            fillColor: Color(0xfff8f8f8),
                                            prefixIcon:
                                                Icon(Icons.person_2_outlined),
                                            prefixIconColor: Color(0xff87cff1),
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
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
                                            child: Text('كلملة السر',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff4FACD7))),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 25.0),
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
                                            return null;
                                          },
                                          onSaved: (value) {
                                            pass = value!;
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
                                            hintTextDirection:
                                                TextDirection.rtl,
                                            filled: true,
                                            fillColor: Color(0xfff8f8f8),
                                            prefixIcon:
                                                Icon(Icons.lock_outline),
                                            prefixIconColor: Color(0xff87cff1),
                                            suffixIconColor: Color(0xff87cff1),
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
                                          ),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
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
                                                            Forgetpassword()),
                                                  );
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Color(
                                                      0xffffffff), // Text color
                                                  side: BorderSide.none,
                                                  // Border color
                                                  padding: EdgeInsets.fromLTRB(
                                                      10,
                                                      20,
                                                      5,
                                                      20), // Button padding
                                                ),
                                                child: Text(
                                                  ' هل نسيت كلمة السر؟',
                                                  style: TextStyle(
                                                      color: Color(0xff4FACD7),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Container(
                                            child: OutlinedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .login(
                                                userName:
                                                    _usernameController.text,
                                                password:
                                                    _passwordController.text,
                                              );
                                            }
                                          },
                                          style: OutlinedButton.styleFrom(
                                            shadowColor: Colors.lightBlue,

                                            backgroundColor:
                                                Color(0xFF76DEFF), // Text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: Colors
                                                      .blue), // Rounded corners
                                            ),
                                            // Border color
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                15,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                15), // Button padding
                                          ),
                                          child: Text(
                                            state is LoginLoadingState
                                                ? 'جاري التحميل ....'
                                                : ' تسجيل الدخول',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          Text(
                                            'او المواصلة ب',
                                            style: TextStyle(
                                              color: Color(0xff4FACD7),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                          child: Stack(
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              shadowColor: Colors.lightBlue,

                                              backgroundColor: Color(
                                                  0xffffffff), // Text color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                // Rounded corners
                                              ),
                                              side: BorderSide(
                                                  color: Colors.blue),
                                              // Border color
                                              padding: EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  15,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  15), // Button padding
                                            ),
                                            child: Text(
                                              ' حساب جوجل',
                                              style: TextStyle(
                                                  color: Color(0xff4FACD7),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
                  }
                },
              ),
            );
          },
        ));
  }
}
