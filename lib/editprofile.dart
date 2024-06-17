import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:ONATION/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ONATION/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: EditProfile(),
    );
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TextEditingController userNametex = TextEditingController();
  TextEditingController emailtex = TextEditingController();
  TextEditingController phoneNumbertex = TextEditingController();
  TextEditingController text = TextEditingController();

  String? userName;
  String? userNamefirstletter;

  String? email;
  String? phoneNumber;
  late String _selectedLanguage;
  Language _language = Language();

  void initState() {
    super.initState();
    _loadLanguage();
    _loadUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserData();
    });

    text.text = 'loading..';
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phoneNumber');
      // Set the controller text values only after data is loaded
      userNametex.text = userName ?? '';
      emailtex.text = email ?? '';
      phoneNumbertex.text = phoneNumber ?? '';
    });
  }

  Future<void> _fetchUserData() async {
    try {
      await context.read<AuthCubit>().fetchUserData();
      _loadUserInfo(); // Reload the user info after fetching new data
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void dispose() {
    userNametex.dispose();
    emailtex.dispose();
    phoneNumbertex.dispose();

    super.dispose();
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
    });
  }

  final _formKey = GlobalKey<FormState>();
  Future<void> _refreshProfile() async {
    await _fetchUserData(); // Fetch updated user data
    _loadLanguage(); // Reload language settings
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is FetchDataSuccess) {
        setState(() {
          userName = state.data['userName'];
          email = state.data['email'];
          phoneNumber = state.data['phoneNumber'];
          userNamefirstletter = state.data['userName'][0];

          // Update the controllers with new data
          userNametex.text = userName ?? '';
          emailtex.text = email ?? '';
          phoneNumbertex.text = phoneNumber ?? '';
        });
      }

      if (state is ProfileUpdateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            alignment: Alignment.center,
            height: 50,
          ),
          backgroundColor: Color(0xff4FACD7),
        ));
        _refreshIndicatorKey.currentState?.show();
      } else if (state is ProfileUpdateFailure) {
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
      if (state is FetchDataLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
          body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshProfile,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                color: isDarkMode ? Colors.black : Color(0xFF76DEFF),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: _selectedLanguage == "EN"
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Setting()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      textDirection: TextDirection.ltr,
                                      color: Colors.white,
                                    )

                                    // color: Color(0xffffffff), // Icon color
                                    )
                                : null,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: _selectedLanguage == 'AR'
                                  ? isPortrait
                                      ? screenWidth * 0.72
                                      : screenWidth * 0.84
                                  : 0,
                            ),
                            child: Text(
                              _language.twelcome(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            child: _selectedLanguage == "AR"
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Setting()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      textDirection: TextDirection.rtl,
                                      color: Colors.white,
                                    )

                                    // color: Color(0xffffffff), // Icon color
                                    )
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                height: isPortrait ? screenHeight : screenHeight * 2,
                margin: EdgeInsets.only(
                    top:
                        isPortrait ? screenHeight * 0.14 : screenHeight * 0.24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isDarkMode
                      ? Colors.black
                      : Colors.white, // Make it circular
                  //color: Colors.white,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.075,
                      screenHeight * 0.075,
                      screenWidth * 0.05,
                      screenHeight * 0.05),
                  child: Directionality(
                    textDirection: _selectedLanguage == 'AR'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.01),
                                child: Text(
                                  _language.tuser(),
                                  style: TextStyle(
                                      fontSize: isPortrait
                                          ? screenWidth * 0.04
                                          : screenHeight * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Color(
                                              0xff4FACD7)), // Set text color based on theme

                                  // color: Color(0xff4FACD7)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          TextFormField(
                            controller: userNametex,
                            decoration: InputDecoration(
                              filled: isDarkMode ? true : false,
                              fillColor: Colors.white,
                              //  hintText: 'Alyaa Hassan',
                              prefixIcon: Icon(Icons.person_2_outlined),
                              prefixIconColor:
                                  isDarkMode ? Colors.black : Color(0xff87cff1),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.blue), // Border color
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        isDarkMode ? Colors.black : Colors.blue,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: isPortrait
                                    ? screenWidth * 0.046
                                    : screenHeight * 0.046,
                                color: Colors.black),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.01),
                                child: Text(
                                  _language.temail(),
                                  style: TextStyle(
                                      fontSize: isPortrait
                                          ? screenWidth * 0.04
                                          : screenHeight * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Color(0xff4FACD7)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          TextFormField(
                            controller: emailtex,
                            decoration: InputDecoration(
                              filled: isDarkMode ? true : false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor:
                                  isDarkMode ? Colors.black : Color(0xff87cff1),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.blue,
                                      width: 6)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        isDarkMode ? Colors.black : Colors.blue,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: isPortrait
                                    ? screenWidth * 0.046
                                    : screenHeight * 0.046,
                                color: Colors.black),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.01),
                                child: Text(
                                  _language.tphone(),
                                  style: TextStyle(
                                      fontSize: isPortrait
                                          ? screenWidth * 0.04
                                          : screenHeight * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Color(0xff4FACD7)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          TextFormField(
                            controller: phoneNumbertex,
                            decoration: InputDecoration(
                              filled: isDarkMode ? true : false,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.phone),
                              prefixIconColor:
                                  isDarkMode ? Colors.black : Color(0xff87cff1),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.blue,
                                      width: 6)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        isDarkMode ? Colors.black : Colors.blue,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: isPortrait
                                    ? screenWidth * 0.046
                                    : screenHeight * 0.046,
                                color: Colors.black),
                          ),
                          SizedBox(height: screenHeight * 0.16),
                          Center(
                            child: SizedBox(
                              // width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  // Collect user data
                                  final userData = {
                                    'userName': userNametex.text,
                                    'email': emailtex.text,
                                    'phoneNumber': phoneNumbertex.text,
                                  };

                                  // Dispatch update profile event with user token and data
                                  context
                                      .read<AuthCubit>()
                                      .updateProfile(userData);
                                },
                                style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  backgroundColor: isDarkMode
                                      ? Colors.white
                                      : Color(0xff4FACD7),
                                  // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: Colors.blue), // Rounded corners
                                  ),
                                  // Border color
                                  padding: EdgeInsets.fromLTRB(
                                    screenWidth * 0.13,
                                    screenHeight * 0.03,
                                    screenWidth * 0.13,
                                    screenHeight * 0.03,
                                  ),
                                ),
                                child: Text(
                                  _language.tchanges(),
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.035,
                    top:
                        isPortrait ? screenHeight * 0.045 : screenHeight * 0.15,
                  ),
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: isDarkMode
                          ? Colors.white
                          : Color(
                              0xFF76DEFF), // You can customize the container's color
                    ),
                    alignment: Alignment
                        .center, // Centers the text inside the container
                    child: Text(
                      userNamefirstletter ??
                          '', // Replace 'A' with the letter you want
                      style: TextStyle(
                        fontSize: 35, // Adjust the font size as needed
                        color: isDarkMode
                            ? Colors.black
                            : Colors.white, // Adjust the text color as needed
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });
  }
}
