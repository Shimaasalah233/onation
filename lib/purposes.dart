import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/paper.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/cities.dart';
import 'package:ONATION/main.dart';
import 'package:ONATION/touristplaces.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:ONATION/pagesdarkmode/purposesdark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurposesPage extends StatelessWidget {
  final String countryId;

  const PurposesPage({Key? key, required this.countryId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Purposes(),
    );
  }
}

class Purposes extends StatefulWidget {
  @override
  _Purposes createState() => _Purposes();
}

class _Purposes extends State<Purposes> {
  late String _selectedLanguage = 'AR';
  bool isDarkMode = false;
  Language _language = Language();
  late Future<List<Purpose>> _purposesFuture;
  late int _selectedCountryId; // Store the selected country ID
  bool _loadingLanguage = true; // Track loading state

  final List<String> images = [
    'images/work.jpg',
    'images/study.jpg',
    'images/tourisme.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _purposesFuture = context.read<AuthCubit>().fetchPurposes();
  }

  void _onCountrySelected(int countryId) {
    setState(() {
      _selectedCountryId = countryId;
    });
  }

  _loadLanguage() async {
    setState(() {
      _loadingLanguage = true; // Start loading language
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
      _loadingLanguage = false; // Language loaded, set loading state to false
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check for orientation
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _loadingLanguage
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    // Main content
                    Container(
                      color: isDarkMode ? Colors.black : Colors.white,
                      child: Column(
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
                                                  ? screenWidth * 0.86
                                                  : screenWidth * 0.92
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
                          SizedBox(
                              height: isPortrait
                                  ? screenWidth * 0.05
                                  : screenHeight * 0.05),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: _selectedLanguage == 'AR'
                                      ? isPortrait
                                          ? screenWidth * 0.7
                                          : screenWidth * 0.85
                                      : screenWidth * 0.05,
                                ),
                                child: Text(
                                  _language.tpurpose(),
                                  style: TextStyle(
                                    fontSize: isPortrait
                                        ? screenWidth * 0.05
                                        : screenHeight * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xff5c9cd0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: isPortrait
                                  ? screenWidth * 0.05
                                  : screenHeight * 0.05),
                          FutureBuilder<List<Purpose>>(
                            future: _purposesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                List<Purpose> purposes = snapshot.data!;
                                return Column(
                                  children:
                                      List.generate(purposes.length, (index) {
                                    return SizedBox(
                                      width: isPortrait
                                          ? screenWidth * 0.825
                                          : screenHeight * 1.65,
                                      child: CardWidget(
                                        imagePath:
                                            images[index % images.length],
                                        purpose: purposes[index],
                                      ),
                                    );
                                  }),
                                );
                              } else {
                                return Center(child: Text('No purposes found'));
                              }
                            },
                          ),
                          SizedBox(
                              height: isPortrait
                                  ? screenWidth * 0.125
                                  : screenHeight * 0.125),
                          Container(
                            padding: EdgeInsets.only(
                              right: isPortrait
                                  ? screenWidth * 0.0625
                                  : screenHeight * 0.0625,
                            ),
                            child: DoubleCardButton(),
                          ),
                          SizedBox(
                              height: isPortrait
                                  ? screenWidth * 0.125
                                  : screenHeight * 0.125),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  final String imagePath;
  final Purpose purpose;

  CardWidget({Key? key, required this.imagePath, required this.purpose})
      : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paperpage(),
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.375,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.0),
                ),
                elevation: 4.0,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.asset(
                        widget.imagePath,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.0),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Text(
                          widget.purpose.purposeName,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isHovered,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23.0),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            widget.purpose.purposeName,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class DoubleCardButton extends StatefulWidget {
  @override
  State<DoubleCardButton> createState() => _DoubleCardButtonState();
}

class _DoubleCardButtonState extends State<DoubleCardButton> {
  late String _selectedLanguage = 'AR';

  Language _language = Language();

  void initState() {
    super.initState();
    _loadLanguage();
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: _selectedLanguage == 'AR'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 116, // عرض الكارت
                      height: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cities(),
                            ),
                          );
                          // إجراء عند الضغط على الكارت
                        },
                        child: Card(
                          color: isDarkMode ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // قيمة الارتفاع التي تريدها
                          child: Column(
                            children: [
                              Container(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                width: 60, // عرض الكارت
                                height: 45, // ارتفاع الكارت
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'images/buildings.png', // استبدل بمسار الصورة الخاصة بك
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                height: 15,
                              ),
                              Text(
                                _language.tcity(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xff4FACD7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 116, // عرض الكارت
                      height: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Touristsplaces(),
                            ),
                          );
                          // إجراء عند الضغط على الكارت
                        },
                        child: Card(
                          color: isDarkMode ? Colors.black : Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 5, // قيمة الارتفاع التي تريدها
                          child: Column(
                            children: [
                              Container(height: 5),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                width: 47, // عرض الكارت
                                height: 44, // ارتفاع الكارت
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'images/tourists2.png', // استبدل بمسار الصورة الخاصة بك
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(height: 15),
                              Text(
                                _language.ttourist(),
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Color(0xff4FACD7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text(
          _language.tmore(),
          style: TextStyle(fontSize: 20),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15, horizontal: screenWidth * 0.08),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 18),
          ),
          foregroundColor: MaterialStateProperty.all(
              isDarkMode ? Colors.black : Colors.white), // لتغيير لون النص
          backgroundColor: MaterialStateProperty.all(
              isDarkMode ? Colors.white : Color(0xff4FACD7)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
