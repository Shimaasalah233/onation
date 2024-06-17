import 'package:ONATION/changepass.dart';
import 'package:ONATION/main.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ONATION/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Add more styling as needed
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  // Add more styling as needed
);

class Setting extends StatefulWidget {
  @override
  _Setting createState() => _Setting();
}

class _Setting extends State<Setting> {
  get items => null;

  Language _language = Language();
  List<String> _languages = ['AR', 'EN'];
  String? _selectedLanguage; // Change to nullable
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadLanguage(); // Load language when widget initializes
  }

// Load language from SharedPreferences
  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load selected language from SharedPreferences, default to 'AR' if not found
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      // Set the language for localization
      _language.setLanguage(_selectedLanguage!);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
// Use null check operator
    });
  }

// Save language to SharedPreferences
  _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  void _toggleThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
      prefs.setBool('darkMode', isDarkMode); // Store new mode
      // Toggle dark mode boolean
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        actions:
        [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleThemeMode,
          ),
        ];
        body:
        Center(
          child: Text('Dark Mode: $isDarkMode'),
        );
        var children2 = [
          Container(
              padding: EdgeInsets.only(
            left: screenWidth * 0.01,
          )),
          DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newValue) async {
              if (newValue != null) {
                // Save selected language to SharedPreferences
                await _saveLanguage(newValue);
                // Update language and state
                _language.setLanguage(newValue);
                setState(() {
                  _selectedLanguage = newValue;
                });
              }
            },
            items: _languages.map((String lang) {
              return DropdownMenuItem<String>(
                child: Text(
                  lang,
                  style: TextStyle(
                    fontSize: 18, // Adjust the font size as needed
                    color: isDarkMode
                        ? Colors.white
                        : Color(0xff4FACD7), // Customize the text color
                  ),
                ),
                value: lang,
              );
            }).toList(),
            style: TextStyle(
              fontSize: 18, // Adjust the font size as needed
              color: isDarkMode
                  ? Colors.white
                  : Color(0xff4FACD7), // Customize the text color
            ),
            dropdownColor: isDarkMode
                ? Colors.grey
                : Colors.white, // Customize the dropdown background color
            elevation: 5, // Add elevation to the dropdown
            icon: Icon(
              Icons.arrow_drop_down, // Customize the dropdown icon
              color: isDarkMode
                  ? Colors.white
                  : Color(0xff4FACD7), // Customize the text color
            ),
            underline: Container(), // Remove the default underline
          ),
          Spacer(),
          Text(
            _language.tLanguage(),
            style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: isDarkMode
                    ? Colors.white
                    : Color(0xff4FACD7), // Customize the text color
                fontWeight: FontWeight.w800),
          ),
          SizedBox(width: screenWidth * 0.02),
          Container(
            padding: EdgeInsets.only(
              right: _selectedLanguage == "AR" ? screenWidth * 0.03 : 0,
              left: _selectedLanguage == "AR" ? 0 : screenWidth * 0.03,
            ),
            child: Icon(
              Icons.language_outlined,
              color: isDarkMode
                  ? Colors.white
                  : Color(0xff4FACD7), // Customize the text color
            ),
          ),
        ];

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: _selectedLanguage == "AR"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    _language.tSetting(),
                    style: TextStyle(
                      fontSize:
                          isPortrait ? screenWidth * 0.06 : screenWidth * 0.04,
                      color: isDarkMode ? Colors.white : Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: isDarkMode ? Colors.black : Color(0xFF76DEFF),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  textDirection: _selectedLanguage == 'AR'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Navigationbar(isDarkMode: isDarkMode),
                    ),
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: isDarkMode ? Colors.black : Colors.white,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.02,
                                    left: _selectedLanguage == 'AR'
                                        ? screenWidth * 0.87
                                        : screenWidth * 0.02),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      child: Container(
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
                                      Row(children: children2),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProfile()),
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.teditprof(),
                                              style: TextStyle(
                                                  fontSize: isPortrait
                                                      ? screenWidth * 0.05
                                                      : screenWidth * 0.04,
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
                                            Icons.edit,
                                            size: 25,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Color(0xff4FACD7),
                                          ),
                                        ),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.tDarkm(),
                                              style: TextStyle(
                                                  fontSize: isPortrait
                                                      ? screenWidth * 0.05
                                                      : screenWidth * 0.04,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            onPressed: () {
                                              _toggleThemeMode(); // Call toggle function when button is pressed
                                            },
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
                                            child: isDarkMode
                                                ? Icon((Icons.light_mode),
                                                    color: Colors.white,
                                                    size: 25)
                                                : Icon((Icons.dark_mode),
                                                    color: Color(0xff4FACD7),
                                                    size: 25)),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        Spacer(),
                                        Container(
                                          child: ElevatedButton(
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: isDarkMode
                                                  ? Colors.black
                                                  : Color(0xffffffff),
                                            ),
                                            child: Text(
                                              _language.tchangepass(),
                                              style: TextStyle(
                                                  fontSize: isPortrait
                                                      ? screenWidth * 0.05
                                                      : screenWidth * 0.04,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Color(0xff4FACD7),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Changpass(),
                                                ),
                                              );
                                            },
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
                                              Icons.lock,
                                              size: 25,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Color(0xff4FACD7),
                                            )),
                                      ]),
                                    ],
                                  ))))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildItems() => items;
}
