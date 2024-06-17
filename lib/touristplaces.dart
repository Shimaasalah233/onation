import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:ONATION/main.dart';
import 'package:ONATION/purposes.dart';

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Touristsplaces(),
    );
  }
}

class Touristsplaces extends StatefulWidget {
  @override
  _Touristsplaces createState() => _Touristsplaces();
}

class _Touristsplaces extends State<Touristsplaces> {
  late String _selectedLanguage;
  late Future<List<Place>> _placesFuture;
  late int _selectedCountryId; // Store the selected country ID

  Language _language = Language();

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
    fetchPlacesByCountry(_selectedCountryId);
  }

  List<Place> filterPlacesByCountry(List<Place> places, int countryId) {
    return places.where((place) => place.countryId == countryId).toList();
  }

  Future<void> fetchPlacesByCountry(int countryId) async {
    setState(() {
      _placesFuture = _fetchPlaces();
    });
  }

  Future<List<Place>> _fetchPlaces() async {
    try {
      // Fetch the places here
      List<Place> allPlaces = await context.read<AuthCubit>().fetchPlaces();
      // Filter places based on the selected country ID
      List<Place> filteredPlaces =
          filterPlacesByCountry(allPlaces, _selectedCountryId);
      return filteredPlaces;
    } catch (e) {
      // Handle errors
      throw Exception('Failed to fetch places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return OrientationBuilder(
      builder: (context, orientation) {
        double screenWidth = MediaQuery.of(context).size.width;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: isDarkMode ? Colors.black : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          height: orientation == Orientation.portrait
                              ? 190
                              : 120, // Adjust height for landscape mode
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
                          height: orientation == Orientation.portrait
                              ? 190
                              : 120, // Adjust height for landscape mode
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
                                  fontSize: orientation == Orientation.portrait
                                      ? screenWidth * 0.07
                                      : screenWidth * 0.04,
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
                          padding:
                              EdgeInsets.fromLTRB(screenWidth * 0.03, 0, 0, 0),
                          child: _selectedLanguage == 'EN'
                              ? Image.asset(
                                  'images/tourists.png',
                                  width: orientation == Orientation.portrait
                                      ? screenWidth * 0.07
                                      : screenWidth * 0.05,
                                  height: orientation == Orientation.portrait
                                      ? screenWidth * 0.07
                                      : screenWidth * 0.05,
                                )
                              : SizedBox(),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              _selectedLanguage == 'AR'
                                  ? screenWidth * 0.64
                                  : 0,
                              0,
                              _selectedLanguage == 'AR' ? 0 : screenWidth * 0.5,
                              0,
                            ),
                            child: Text(
                              _language.ttourist(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? screenWidth * 0.04
                                    : screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white
                                    : Color(0xff5c9cd0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(0, 0, screenWidth * 0.03, 0),
                          child: _selectedLanguage == 'AR'
                              ? Image.asset(
                                  'images/tourists.png',
                                  width: orientation == Orientation.portrait
                                      ? screenWidth * 0.07
                                      : screenWidth * 0.05,
                                  height: orientation == Orientation.portrait
                                      ? screenWidth * 0.07
                                      : screenWidth * 0.05,
                                )
                              : SizedBox(),
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
                          width: orientation == Orientation.portrait
                              ? screenWidth * 0.07
                              : screenWidth * 0.05,
                          height: orientation == Orientation.portrait
                              ? screenWidth * 0.07
                              : screenWidth * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    FutureBuilder<List<Place>>(
                      future: _placesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.portrait
                                        ? 2
                                        : 3, // Adjust based on orientation
                                crossAxisSpacing: screenWidth * 0.03,
                                mainAxisSpacing: screenWidth * 0.03,
                                childAspectRatio:
                                    orientation == Orientation.portrait
                                        ? 1
                                        : 1.3, // Adjust as needed
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Place place = snapshot.data![index];
                                return CardWidget(
                                  imagePath: place.placeImage,
                                  title: place.placeName,
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('No places found');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
        width: isPortrait
            ? screenWidth * 0.75
            : screenWidth * 0.3, // Adjust width for landscape mode
        height: isPortrait
            ? screenWidth * 0.4
            : screenWidth * 0.3, // Adjust height for landscape mode
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
