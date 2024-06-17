//import 'package:ONATION/loginandregisteration/main2.dart';
import 'package:ONATION/main.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:ONATION/purposes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paperpage extends StatefulWidget {
  Paperpage({Key? key}) : super(key: key);

  @override
  _PaperpageState createState() => _PaperpageState();
}

class _PaperpageState extends State<Paperpage> {
  late String _selectedLanguage;
  late ScrollController _scrollController;
  Language _language = Language();

  void initState() {
    super.initState();
    _loadLanguage();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateButtonPosition);
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(children: [
            SingleChildScrollView(
              controller: _scrollController,
              // Listen for scroll events to update button position

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
                                          ? screenWidth * 0.88
                                          : 0,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Purposes(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        textDirection: _selectedLanguage == 'AR'
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
                                        : screenHeight * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                              width: screenWidth,
                              height: isPortrait
                                  ? screenHeight * 2
                                  : screenHeight * 3,
                              color: isDarkMode ? Colors.black : Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        _selectedLanguage == 'AR'
                                            ? screenWidth * 0.72
                                            : 0,
                                        20,
                                        _selectedLanguage == 'EN'
                                            ? screenWidth * 0.7
                                            : 0,
                                        20),
                                    child: Text(
                                      _language.tpaper(),
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
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' +
                                          '\n' +
                                          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ' +
                                          '\n' +
                                          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.' +
                                          '\n' +
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' +
                                          '\n' +
                                          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.' +
                                          '\n' +
                                          ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Color(0xff5c9cd0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ShowMoreButton(
                                      content:
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CountryButton(),
                                ],
                              )),
                          // Adjust as needed
                        ],
                      )
                    ],
                  )),
            ),
            FloatingButton(
                bottomPadding: _bottomPadding, rightPadding: _rightPadding),
          ]),
        ));
  }
}

class ShowMoreButton extends StatefulWidget {
  final String content;

  ShowMoreButton({Key? key, required this.content}) : super(key: key);

  @override
  _ShowMoreButtonState createState() => _ShowMoreButtonState();
}

class _ShowMoreButtonState extends State<ShowMoreButton> {
  bool _showMore = false;
  String? _selectedLanguage;

  Language _language = Language();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    // Check for orientation
    //bool isPortrait =MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  _selectedLanguage == 'AR' ? screenWidth * 0.63 : 0, 10, 0, 0),
              child: _selectedLanguage == 'AR'
                  ? Icon(
                      _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                    )
                  : null,
            ),
            if (widget.content.length > 0)
              TextButton(
                  onPressed: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      _language.tdet(),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      ),
                    ),
                  )),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10,
                    _selectedLanguage == 'AR' ? 0 : screenWidth * 0.5, 0),
                child: _selectedLanguage == 'EN'
                    ? Icon(
                        _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      )
                    : null),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            _showMore ? widget.content : widget.content.substring(0, 0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
            ),
          ),
        ),
      ],
    );
  }
}

class NotesButton extends StatefulWidget {
  final String content;

  NotesButton({Key? key, required this.content}) : super(key: key);

  @override
  _NotesButtonState createState() => _NotesButtonState();
}

class _NotesButtonState extends State<NotesButton> {
  bool _showMore = false;
  String? _selectedLanguage;

  Language _language = Language();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    // Check for orientation
    //bool isPortrait =MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  _selectedLanguage == 'AR' ? screenWidth * 0.69 : 0, 0, 0, 0),
              child: _selectedLanguage == 'AR'
                  ? Icon(
                      _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                    )
                  : null,
            ),
            if (widget.content.length > 0)
              TextButton(
                  onPressed: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        _selectedLanguage == 'EN' ? screenWidth * 0.03 : 0,
                        0,
                        0,
                        0),
                    child: Text(
                      _language.tnotes(),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      ),
                    ),
                  )),
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, _selectedLanguage == 'AR' ? 0 : screenWidth * 0.5, 0),
                child: _selectedLanguage == 'EN'
                    ? Icon(
                        _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      )
                    : null),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            _showMore ? widget.content : widget.content.substring(0, 0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
            ),
          ),
        ),
      ],
    );
  }
}

class EmbisesButton extends StatefulWidget {
  final String content;

  EmbisesButton({Key? key, required this.content}) : super(key: key);

  @override
  _EmbisesButtonState createState() => _EmbisesButtonState();
}

class _EmbisesButtonState extends State<EmbisesButton> {
  bool _showMore = false;
  String? _selectedLanguage;

  Language _language = Language();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    // Check for orientation
    //bool isPortrait =MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  _selectedLanguage == 'AR' ? screenWidth * 0.69 : 0, 0, 0, 0),
              child: _selectedLanguage == 'AR'
                  ? Icon(
                      _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                    )
                  : null,
            ),
            if (widget.content.length > 0)
              TextButton(
                  onPressed: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        _selectedLanguage == 'EN' ? screenWidth * 0.03 : 0,
                        0,
                        0,
                        0),
                    child: Text(
                      _language.tembises(),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      ),
                    ),
                  )),
            Container(
                margin: EdgeInsets.fromLTRB(
                    0, 0, _selectedLanguage == 'AR' ? 0 : screenWidth * 0.5, 0),
                child: _selectedLanguage == 'EN'
                    ? Icon(
                        _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      )
                    : null),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            _showMore ? widget.content : widget.content.substring(0, 0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
            ),
          ),
        ),
      ],
    );
  }
}

class CountryButton extends StatefulWidget {
  CountryButton({
    Key? key,
  }) : super(key: key);

  @override
  _CountryButtonState createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton> {
  bool _showMore = false;
  String? _selectedLanguage;

  Language _language = Language();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  _selectedLanguage == 'AR' ? screenWidth * 0.67 : 0, 0, 0, 0),
              child: _selectedLanguage == 'AR'
                  ? Icon(
                      _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                    )
                  : null,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
              child: Container(
                child: Text(
                  _language.taboutcountry(),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, 0, _selectedLanguage == 'AR' ? 0 : screenWidth * 0.5, 0),
              child: _selectedLanguage == 'EN'
                  ? Icon(
                      _showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                    )
                  : null,
            ),
          ],
        ),
        SizedBox(height: 3),
        Visibility(
          visible: _showMore,
          child: Column(
            children: [
              // Add other buttons here

              NotesButton(
                  content:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
              EmbisesButton(
                  content:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            ],
          ),
        ),
      ],
    );
  }
}

class FloatingButton extends StatefulWidget {
  FloatingButton(
      {Key? key, required this.bottomPadding, required this.rightPadding})
      : super(key: key);
  final double bottomPadding;
  final double rightPadding;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  late String _selectedLanguage;

  Language _language = Language();

  void initState() {
    super.initState();
    _loadLanguage();
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
    return Positioned(
      bottom: widget.bottomPadding, // Use bottomPadding here
      right: widget.rightPadding, // Use rightPadding here
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Set the border radius here
        ),
        backgroundColor: isDarkMode ? Colors.white : Color(0xff3DC9F5),
        onPressed: () {
          // Show dialog here
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.8,
                title: Text(
                  _language.taddcomment(),
                  textDirection: _selectedLanguage == 'AR'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Color(0xff5c9cd0)),
                ),
                content: Directionality(
                  textDirection: _selectedLanguage == 'AR'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: _language.tcomment(),
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.black
                                    : Color(0xff5c9cd0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_selectedLanguage == 'EN')
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                isDarkMode ? Colors.black : Color(0xff3DC9F5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(_language.tadd(),
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Color(0xffffffff))),
                        ),
                      SizedBox(width: 8), // Add some space between buttons
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(_language.tcancel(),
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.black
                                    : Color(0xff5c9cd0))),
                      ),
                      SizedBox(width: 8),
                      if (_selectedLanguage == 'AR')
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                isDarkMode ? Colors.black : Color(0xff3DC9F5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text(
                            _language.tadd(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: isDarkMode ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

/*shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius here
                ),*/
/* child: Container(
                  height: screenHeight * 0.39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Same as the shape's border radius
                    color:
                        Colors.white, // Adjust the background color if needed
                  ),*/
