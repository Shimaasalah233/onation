import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ONATION/loginandregisteration/registerationway.dart';
import 'package:ONATION/loginandregisteration/haveaccount.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MakeAccount(),
    );
  }
}

class MakeAccount extends StatefulWidget {
  @override
  _MakeAccount createState() => _MakeAccount();
}

class _MakeAccount extends State<MakeAccount> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String pass = '';
  String confirm_pass = '';
  String email = '';
  bool _obscureText = true;
  bool _obscureText2 = true;

  bool isValidEmail(String email) {
    // Basic email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidphone(String phone) {
    // Basic email validation
    return RegExp(r'^[0-9]{11}$').hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    String Phonelabel1 = 'رقم الهاتف';
    String Phonelabel = Phonelabel1;
    String text1 = 'يجب ان تحتوي كلمة السر على الاقل:';
    String text2 = 'ثمانية حروف أو أرقام';
    String text3 = 'رمز مميز واحد';
    String text4 = 'حرف كبير واحد';
    String text5 = 'حرف صغير واحد';
    String errorText = text1 +
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
      if (state is RegisterSuccessState) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white, // Set background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Set rounded corners
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.message,
                  style: TextStyle(color: Color(0xff4FACD7), fontSize: 18.0),
                ),
                SizedBox(
                    height: 20.0), // Add some space between text and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HaveAccount(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF76DEFF),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Set rounded corners
                    ),
                  ),
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xffffffff),
                    ),
                    // Set button background color
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is FailedToRegisterState) {
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
    }, builder: (context, state) {
      return OrientationBuilder(builder: (context, orientation) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        return Scaffold(
            body: SingleChildScrollView(
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
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(right: screenWidth * 0.01),
                            child: Text(
                              'انشئ حساب',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Registerationway(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              textDirection: TextDirection.rtl,
                            ),
                            color: Colors.white, // Icon color
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                height: isPortrait ? screenHeight * 2 : screenHeight * 3,
                margin: EdgeInsets.only(
                  top: isPortrait ? screenHeight * 0.12 : screenHeight * 0.3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Make it circular
                  color: Colors.white,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'اسم المستخدم',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4FACD7),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _usernameController,
                            validator: (value) {
                              if (_usernameController.text.isEmpty) {
                                return 'من فضلك ادخل الاسم';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              filled: true,
                              fillColor: Color(0xfff8f8f8),
                              prefixIcon: Icon(Icons.person_2_outlined),
                              prefixIconColor: Color(0xff87cff1),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 15.0,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'البريد الالكتروني',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4FACD7),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (_emailController.text.isEmpty) {
                                return 'من فضلك ادخل البريد الالكتروني';
                              }
                              if (!isValidEmail(_emailController.text)) {
                                return 'من فضلك ادخل بريد الكتروني صالح';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              filled: true,
                              fillColor: Color(0xfff8f8f8),
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: Color(0xff87cff1),
                              suffixIconColor: Color(0xff87cff1),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 15.0,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'كلمة السر',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4FACD7),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (_passwordController.text.isEmpty) {
                                return 'من فضلك ادخل كلمة السر';
                              }

                              if (_passwordController.text.length < 8) {
                                return errorText;
                              }

                              // Add your own additional criteria for strong password validation
                              if (!_containsSpecialCharacter(
                                  _passwordController.text)) {
                                return errorText;
                              }
                              if (!_containsNumber(_passwordController.text)) {
                                return errorText;
                              }
                              if (!_containsUppercase(
                                  _passwordController.text)) {
                                return errorText;
                              }
                              if (!_containsLowercase(
                                  _passwordController.text)) {
                                return errorText;
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
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 15.0,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'تأكيد كلمة السر',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4FACD7),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _confirmpasswordController,
                            obscureText: _obscureText2,
                            validator: (value) {
                              if (_confirmpasswordController.text.isEmpty) {
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
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 15.0,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  Phonelabel,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4FACD7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _phonenumberController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (_phonenumberController.text.isEmpty) {
                                return 'من فضلك ادخل رقم الهاتف';
                              }
                              if (!isValidphone(_phonenumberController.text)) {
                                return 'من فضلك أدخل رقم هاتف صالح';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              filled: true,
                              fillColor: Color(0xfff8f8f8),
                              prefixIcon: Icon(Icons.phone_android_outlined),
                              prefixIconColor: Color(0xff87cff1),
                              suffixIconColor: Color(0xff87cff1),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 15.0,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: OutlinedButton(
                                onPressed: () {
                                  // Call the sign-up method when the button is pressed
                                  if (_formKey.currentState!.validate()) {
                                    // Call the sign-up method when the button is pressed
                                    BlocProvider.of<AuthCubit>(context).signUp(
                                        userName: _usernameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        passwordConfirmed:
                                            _confirmpasswordController.text,
                                        phoneNumber:
                                            _phonenumberController.text);

                                    /* print('Name: $_username');
                                          print('password: $pass');
                                          print(
                                              'Confirmed password: $confirm_pass');
                                          print('E-mail: $email');*/
                                  } // Call the sign-up method when the button is pressed
                                },
                                style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.lightBlue,
                                  backgroundColor:
                                      Color(0xFF76DEFF), // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: Colors.blue,
                                    ), // Rounded corners
                                  ),
                                  // Border color
                                  padding: EdgeInsets.fromLTRB(
                                    screenWidth * 0.1,
                                    isPortrait
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.01,
                                    screenWidth * 0.1,
                                    isPortrait
                                        ? screenHeight * 0.02
                                        : screenHeight * 0.01,
                                  ), // Button padding
                                ),
                                child: Text(
                                  state is RegisterLoadingState
                                      ? 'جاري التحميل ....'
                                      : ' تسجيل الدخول',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
      });
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
