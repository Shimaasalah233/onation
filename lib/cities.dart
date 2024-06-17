import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/main.dart';
import 'package:ONATION/purposes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Cities(),
    );
  }
}

class Cities extends StatefulWidget {
  @override
  _Cities createState() => _Cities();
}

class _Cities extends State<Cities> {
  late String _selectedLanguage;
  bool _isLoading = true;
  Language _language = Language();
  late Future<List<City>> _citiesFuture;
  late int _selectedCountryId;

  @override
  void initState() {
    super.initState();
    _loadLanguageAndCountry();
  }

  Future<void> _loadLanguageAndCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
      _selectedCountryId =
          prefs.getInt('selectedCountryId') ?? 0; // Load country ID
    });
    fetchCitiesByCountry(_selectedCountryId);
  }

  List<City> filterCitiesByCountry(List<City> cities, int countryId) {
    return cities.where((city) => city.countryId == countryId).toList();
  }

  Future<void> fetchCitiesByCountry(int countryId) async {
    try {
      setState(() {
        _isLoading = true; // Set loading to true before fetching data
      });
      // Fetch all places
      List<City> allCities = await context.read<AuthCubit>().fetchCities();

      // Filter places based on the selected country ID
      List<City> filteredCities = filterCitiesByCountry(allCities, countryId);

      setState(() {
        _citiesFuture = Future.value(filteredCities);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false if an error occurs
      });
      // Handle errors
    }
  }

  Future<List<City>> _fetchCities() async {
    // Fetch the places here
    return context.read<AuthCubit>().fetchCities();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Added for full width
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: isPortrait ? 190 : 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                      child: Image.asset(
                        isDarkMode ? 'images/darksky.jpg' : 'images/sky.jpg',
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
                    height: isPortrait ? 190 : 120,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: _selectedLanguage == 'AR'
                                  ? isPortrait
                                      ? screenWidth * 0.85
                                      : screenWidth * 0.9
                                  : 0,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                ? screenWidth * 0.075
                                : screenHeight * 0.075,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, 0, 0),
                    child: _selectedLanguage == 'EN'
                        ? Image.asset(
                            'images/buildings.png',
                            width: isPortrait
                                ? screenWidth * 0.1
                                : screenHeight * 0.1,
                            height: isPortrait
                                ? screenWidth * 0.1
                                : screenHeight * 0.1,
                          )
                        : null,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        _selectedLanguage == 'AR'
                            ? isPortrait
                                ? screenWidth * 0.59
                                : screenWidth * 0.72
                            : screenWidth * 0.02,
                        0,
                        _selectedLanguage == 'AR'
                            ? screenWidth * 0.02
                            : screenWidth * 0.5,
                        0),
                    child: Text(
                      _language.tcity(),
                      style: TextStyle(
                        fontSize: isPortrait
                            ? screenWidth * 0.045
                            : screenHeight * 0.045,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.02, 0),
                    child: _selectedLanguage == 'AR'
                        ? Image.asset(
                            'images/buildings.png',
                            width: isPortrait
                                ? screenWidth * 0.1
                                : screenHeight * 0.1,
                            height: isPortrait
                                ? screenWidth * 0.1
                                : screenHeight * 0.1,
                          )
                        : null,
                  ),
                ],
              ),
              SizedBox(height: 3),
              Container(
                padding: EdgeInsets.fromLTRB(
                  _selectedLanguage == 'AR'
                      ? screenWidth * 0.02
                      : 0, // Adjust the left padding for non-AR language
                  0,
                  _selectedLanguage == 'AR'
                      ? 0
                      : screenWidth *
                          0.02, // Adjust the right padding for non-AR language
                  0,
                ),
                alignment: _selectedLanguage == 'AR'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      isDarkMode ? Colors.white : Color(0xff4FACD7),
                      BlendMode.srcIn),
                  child: Image.asset(
                    _selectedLanguage == 'AR'
                        ? 'images/move.png'
                        : 'images/move2.png',
                    width:
                        isPortrait ? screenWidth * 0.07 : screenHeight * 0.05,
                    height:
                        isPortrait ? screenWidth * 0.07 : screenHeight * 0.05,
                  ),
                ),
              ),
              SizedBox(height: 15),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : FutureBuilder<List<City>>(
                      future: _citiesFuture ?? _fetchCities(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          // Create a list of CardWidgets with three cards in each row for landscape mode
                          List<Widget> cardRows = [];
                          int cardsPerRow = isPortrait ? 2 : 3;
                          for (int i = 0;
                              i < snapshot.data!.length;
                              i += cardsPerRow) {
                            List<Widget> rowCards = [];
                            for (int j = i;
                                j < i + cardsPerRow &&
                                    j < snapshot.data!.length;
                                j++) {
                              rowCards.add(
                                Expanded(
                                  child: CardWidget(
                                    imagePath: snapshot.data![j].cityImage,
                                    title: snapshot.data![j].countryCity1,
                                  ),
                                ),
                              );
                              if (j < i + cardsPerRow - 1 &&
                                  j < snapshot.data!.length - 1) {
                                rowCards.add(SizedBox(width: 10));
                              }
                            }
                            cardRows.add(Row(children: rowCards));
                            cardRows.add(SizedBox(height: 10));
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02),
                            child: Column(
                              children: cardRows,
                            ),
                          );
                        } else {
                          return Center(child: Text('No cities found'));
                        }
                      },
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
  final String title;

  const CardWidget({Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = isPortrait ? screenWidth * 0.75 : screenWidth * 0.3;
    double cardHeight = isPortrait ? screenWidth * 0.4 : screenWidth * 0.3;

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
      child: Container(
        width: cardWidth, // Set explicit width
        height: cardHeight, // Set explicit height
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
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                      widget.title,
                      style: TextStyle(
                        fontSize: 16.0,
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
      ),
    );
  }
}
