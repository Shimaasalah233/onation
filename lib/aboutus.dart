import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:ONATION/main.dart';
//import 'package:ONATION/profile.dart';
import 'package:ONATION/provider/langauge.dart';
//import 'package:ONATION/purposes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: AboutUs(),
    );
  }
}

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late String _selectedLanguage;
  late ScrollController _scrollController;
  Language _language = Language();
  String? aboutus;
  String? ourapp;
  void initState() {
    super.initState();
    _loadLanguage();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateButtonPosition);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchaboutusData();
    });
  }

  Future<void> _fetchaboutusData() async {
    try {
      await context.read<AuthCubit>().fetchaboutusData();
      // Reload the u\ser info after fetching new data
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _bottomPadding = 16.0;
  double _rightPadding = 16.0;
  void _updateButtonPosition() {
    setState(() {
      // Update button position based on scroll offset
      // For example:
      _bottomPadding = 16.0 - _scrollController.offset;
      _rightPadding = 16.0;
    });
  }

  _loadLanguage() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check for orientation
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is FetchaboutusDataSuccess) {
        setState(() {
          aboutus = state.data2[0]['whoAreWe'];
          ourapp = state.data2[0]['ourApp'];
        });
      }
    }, builder: (context, state) {
      if (state is FetchaboutusDataLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: screenWidth,
                              height: isPortrait
                                  ? screenHeight * 0.25
                                  : screenHeight * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                ),
                                child: Image.asset(
                                  isDarkMode
                                      ? 'images/darksky.jpg'
                                      : 'images/sky.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0),
                                ),
                              ),
                              width: screenWidth,
                              height: isPortrait
                                  ? screenHeight * 0.25
                                  : screenHeight * 0.4,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: _selectedLanguage == 'AR'
                                            ? isPortrait
                                                ? screenWidth * 0.88
                                                : screenWidth * 0.93
                                            : 0,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Navigationbar(
                                                      isDarkMode: isDarkMode),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          textDirection:
                                              _selectedLanguage == 'AR'
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                                  child: Text(
                                    'O-NATION',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isPortrait
                                          ? screenWidth * 0.08
                                          : screenHeight * 0.08,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(children: [
                          Container(
                              width: screenWidth,
                              height: isPortrait
                                  ? screenHeight * 2
                                  : screenHeight * 3,
                              color: isDarkMode ? Colors.black : Colors.white,
                              child: Column(children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _selectedLanguage == 'AR'
                                          ? isPortrait
                                              ? screenWidth * 0.8
                                              : screenWidth * 0.89
                                          : 0,
                                      20,
                                      _selectedLanguage == 'EN'
                                          ? isPortrait
                                              ? screenWidth * 0.74
                                              : screenWidth * 0.82
                                          : 0,
                                      20),
                                  child: Text(
                                    _language.taboutproject(),
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Color(0xff5c9cd0),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05),
                                  child: Text(
                                    ourapp ?? 'Loading...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Color(0xff5c9cd0),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _selectedLanguage == 'AR'
                                          ? isPortrait
                                              ? screenWidth * 0.8
                                              : screenWidth * 0.89
                                          : 0,
                                      20,
                                      _selectedLanguage == 'EN'
                                          ? isPortrait
                                              ? screenWidth * 0.77
                                              : screenWidth * 0.85
                                          : 0,
                                      20),
                                  child: Text(
                                    _language.taboutus(),
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Color(0xff5c9cd0),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05),
                                  child: Text(
                                    aboutus ?? 'Loading...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Color(0xff5c9cd0),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _selectedLanguage == 'AR'
                                          ? isPortrait
                                              ? screenWidth * 0.78
                                              : screenWidth * 0.85
                                          : 0,
                                      20,
                                      _selectedLanguage == 'EN'
                                          ? isPortrait
                                              ? screenWidth * 0.63
                                              : screenWidth * 0.77
                                          : 0,
                                      20),
                                  child: Text(
                                    _language.tteam(),
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Color(0xff5c9cd0),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Members(
                                      imagePath: 'images/alaa.jpeg',
                                      name: 'A' + "'" + 'laa Ali',
                                      track: 'Backend Developer',
                                    ),
                                    SizedBox(
                                        width: screenWidth *
                                            0.1), // Add spacing between members if needed
                                    Members(
                                      imagePath: 'images/shereen.jpeg',
                                      name: 'Shereen Hamamy',
                                      track: 'Backend Developer',
                                    ),
                                    // Add more Members widgets for each team member
                                  ],
                                ),
                                SizedBox(height: 35),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Members(
                                      imagePath: 'images/maram.jpeg',
                                      name: 'Maram Mohamed',
                                      track: 'Backend Developer',
                                    ),
                                    SizedBox(
                                        width: screenWidth *
                                            0.1), // Add spacing between members if needed
                                    Members(
                                      imagePath: 'images/donia.jpeg',
                                      name: 'Donia Abdallah',
                                      track: 'Backend Developer',
                                    ),
                                    // Add more Members widgets for each team member
                                  ],
                                ),
                                SizedBox(height: 35),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Members(
                                      imagePath: 'images/shimaa.jpeg',
                                      name: 'El-Shimaa Salah',
                                      track: 'Frontend Developer',
                                    ),
                                    SizedBox(
                                        width: screenWidth *
                                            0.1), // Add spacing between members if needed
                                    Members(
                                      imagePath: 'images/shiamaaad.jpeg',
                                      name: 'Shimaa Adel',
                                      track: 'Frontend Developer',
                                    ),
                                    // Add more Members widgets for each team member
                                  ],
                                ),
                                SizedBox(height: 35),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Members(
                                      imagePath: 'images/eman.jpeg',
                                      name: 'Eman Yehia',
                                      track: 'Flutter Developer',
                                    ),
                                    SizedBox(
                                        width: screenWidth *
                                            0.1), // Add spacing between members if needed
                                    Members(
                                      imagePath: 'images/alyaa.jpeg',
                                      name: 'Alyaa Zakria',
                                      track: 'Flutter Developer',
                                    ),
                                    // Add more Members widgets for each team member
                                  ],
                                ),
                              ]))
                        ])
                      ]))));
    });
  }
}

class Members extends StatelessWidget {
  final String imagePath;
  final String name;
  final String track;

  const Members({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Color(0xff5c9cd0)),
          ),
          SizedBox(height: 5),
          Text(
            track,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
