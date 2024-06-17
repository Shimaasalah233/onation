import 'package:ONATION/aboutus.dart';
import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:ONATION/loginandregisteration/main2.dart';
import 'package:ONATION/favorite.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:ONATION/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Profile(),
    );
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
);

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userName;
  String? userNamefirstletter;

  String? email;
  String? phoneNumber;
  get items => null;

  Language _language = Language();

  String? _selectedLanguage;
  bool isDarkMode = false;
  bool isLanguageLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserData();
    });
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection:
              _selectedLanguage == 'AR' ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  _language.warning(),
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            content: Text(
              _language.sure(),
              style: TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  BlocProvider.of<AuthCubit>(context)
                      .deleteAccount(); // Perform delete action
                },
                child: Text(
                  _language.yes(),
                  style: TextStyle(
                    color: Colors.white,
                  ), // Text color
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  _language.no(),
                  style: TextStyle(color: Color(0xff909293)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phoneNumber');
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

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
      isDarkMode = prefs.getBool('darkMode') ?? false;
      isLanguageLoading = false; // Language has finished loading
    });
  }

  _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is FetchDataSuccess) {
          setState(() {
            userName = state.data['userName'];
            email = state.data['email'];
            phoneNumber = state.data['phoneNumber'];
            userNamefirstletter = state.data['userName'][0];
          });
        }

        if (state is DeleteAccountSuccessState || state is LogoutSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        } else if (state is FailedToDeleteAccountState) {
          print('error');
        }

        if (state is ProfileUpdateSuccess) {
          // Handle successful profile update
          // You may navigate to another page or show a success message
        } else if (state is ProfileUpdateFailure) {
          // Handle profile update failure
          // You may show an error message
          print('Error updating profile: ${state.message}');
        }
      },
      builder: (context, state) {
        if (isLanguageLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FetchDataLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                    width: screenWidth,
                    height: screenHeight,
                    color: isDarkMode ? Colors.black : Color(0xFF76DEFF),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Spacer at the beginning for Arabic to push everything to the right
                              if (_selectedLanguage == "AR") Spacer(),

                              // User name container
                              Container(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  right: _selectedLanguage == "AR"
                                      ? screenWidth * 0.02
                                      : screenWidth * 0.02,
                                  left: _selectedLanguage == "EN"
                                      ? screenWidth * 0.02
                                      : screenWidth * 0.02,
                                ),
                                child: _selectedLanguage == "AR"
                                    ? Text(
                                        userName ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    : Text(
                                        _language.twelcome(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                              ),

                              // Welcome message container
                              Container(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: _selectedLanguage == "AR"
                                      ? screenWidth * 0.01
                                      : screenWidth * 0.01,
                                  right: _selectedLanguage == "EN"
                                      ? screenWidth * 0.01
                                      : screenWidth * 0.01,
                                ),
                                child: _selectedLanguage == "AR"
                                    ? Text(
                                        _language.twelcome(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      )
                                    : Text(
                                        userName ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                              ),

                              // Spacer at the end for English to push everything to the left
                              if (_selectedLanguage == "EN") Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: screenWidth,
                      margin: EdgeInsets.only(
                          top: isPortrait
                              ? screenHeight * 0.14
                              : screenHeight * 0.24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              5, screenHeight * 0.075, 5, 5),
                          child: Directionality(
                              textDirection: _selectedLanguage == 'AR'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: Text(
                                            _language.tinfo(),
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Color(0xff4FACD7)),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Icon(Icons.info_outline,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Color(0xff4FACD7)),
                                      ]),
                                      SizedBox(
                                        height: isPortrait
                                            ? screenHeight * 0.02
                                            : screenHeight * 0.03,
                                      ),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(
                                            userName ??
                                                'Loading...', // Ensure the value is converted to String
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(_language.tuser(),
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7))),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _selectedLanguage == "AR"
                                                ? screenWidth * 0.03
                                                : 0,
                                            left: _selectedLanguage == "AR"
                                                ? 0
                                                : screenWidth * 0.03,
                                          ),
                                          child: Icon(Icons.person_2_outlined,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7)),
                                        ),
                                      ]),
                                      SizedBox(
                                          height: isPortrait
                                              ? screenHeight * 0.02
                                              : screenHeight * 0.03),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(
                                            email ??
                                                'Loading...', // Ensure the value is converted to String
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(_language.temail(),
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Color(0xff4FACD7),
                                              )),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _selectedLanguage == "AR"
                                                ? screenWidth * 0.03
                                                : 0,
                                            left: _selectedLanguage == "AR"
                                                ? 0
                                                : screenWidth * 0.03,
                                          ),
                                          child: Icon(Icons.email_outlined,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7)),
                                        )
                                      ]),
                                      SizedBox(
                                          height: isPortrait
                                              ? screenHeight * 0.02
                                              : screenHeight * 0.03),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(
                                            phoneNumber ??
                                                'Loading...', // Ensure the value is converted to String
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.01,
                                          ),
                                          child: Text(
                                            _language.tphone(),
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Color(0xff4FACD7)),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _selectedLanguage == "AR"
                                                ? screenWidth * 0.03
                                                : 0,
                                            left: _selectedLanguage == "AR"
                                                ? 0
                                                : screenWidth * 0.03,
                                          ),
                                          child: Icon(Icons.phone_android,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7)),
                                        )
                                      ]),
                                      SizedBox(height: screenHeight * 0.02),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Favorite()),
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.tFavorite(),
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _selectedLanguage == "AR"
                                                ? screenWidth * 0.03
                                                : 0,
                                            left: _selectedLanguage == "AR"
                                                ? 0
                                                : screenWidth * 0.03,
                                          ),
                                          child: Icon(
                                            Icons.favorite,
                                            size: 25,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Color(0xff4FACD7),
                                          ),
                                        ),
                                      ]),
                                      SizedBox(height: screenHeight * 0.03),
                                      Divider(
                                        color: Color(0xfff4f2f2),
                                        thickness: 5,
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Setting()),
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.tSetting(),
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Icon(
                                          Icons.settings,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Color(0xff4FACD7),
                                        ),
                                      ]),
                                      SizedBox(height: screenHeight * 0.03),
                                      Divider(
                                        color: Color(0xfff4f2f2),
                                        thickness: 5,
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AboutUs()),
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.tabout(),
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _selectedLanguage == "AR"
                                                ? screenWidth * 0.03
                                                : 0,
                                            left: _selectedLanguage == "AR"
                                                ? 0
                                                : screenWidth * 0.03,
                                          ),
                                          child: Icon(
                                            Icons.group,
                                            size: 25,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Color(0xff4FACD7),
                                          ),
                                        ),
                                      ]),
                                      SizedBox(height: screenHeight * 0.04),
                                      SizedBox(
                                        width: double.infinity,
                                      ),
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.05),
                                            child: OutlinedButton(
                                              onPressed: () {
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .logout();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: isDarkMode
                                                    ? Colors.white
                                                    : Color(0xff4FACD7),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  side: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                  screenWidth * 0.13,
                                                  screenHeight * 0.03,
                                                  screenWidth * 0.13,
                                                  screenHeight * 0.03,
                                                ),
                                              ),
                                              child: Text(
                                                _language.tlogout(),
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            )),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.03),
                                            child: OutlinedButton(
                                              onPressed: () {
                                                /*  BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .deleteAccount();*/
                                                _showWarningDialog();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shadowColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xffe52020),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  side: BorderSide(
                                                      color: Colors.blue),
                                                ),
                                                padding: EdgeInsets.fromLTRB(
                                                  screenWidth * 0.12,
                                                  screenHeight * 0.03,
                                                  screenWidth * 0.12,
                                                  screenHeight * 0.03,
                                                ),
                                              ),
                                              child: Text(
                                                _language.tdelete(),
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.036,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            )),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                    ],
                                  ))))),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.035,
                        top: isPortrait
                            ? screenHeight * 0.045
                            : screenHeight * 0.15,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                : Colors
                                    .white, // Adjust the text color as needed
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  buildItems() => items;
}
