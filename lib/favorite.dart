import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';
import 'package:ONATION/provider/langauge.dart';
import 'package:ONATION/purposes.dart';
import 'package:flutter/material.dart';

import 'package:ONATION/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:ONATION/pagesdarkmode/purposesdark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  @override
  _Favorite createState() => _Favorite();
}

class _Favorite extends State<Favorite> {
  late String _selectedLanguage;
  Language _language = Language();
  bool isDarkMode = false;
  List<String> favoriteCountries = [];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadFavoriteCountries();
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  _loadFavoriteCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteCountries = prefs.getStringList('favorites') ?? [];
    });
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
            children: [
              Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height:
                        isPortrait ? screenHeight * 0.25 : screenHeight * 0.4,
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
                    height:
                        isPortrait ? screenHeight * 0.25 : screenHeight * 0.4,
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
                                      : screenWidth * 0.93
                                  : 0,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Navigationbar(isDarkMode: isDarkMode),
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
                                : screenHeight * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                  height:
                      isPortrait ? screenWidth * 0.05 : screenHeight * 0.05),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: _selectedLanguage == 'AR'
                          ? isPortrait
                              ? screenWidth * 0.66
                              : screenWidth * 0.79
                          : screenWidth * 0.02,
                    ),
                    child: Text(
                      _language.tFavCities(),
                      style: TextStyle(
                        fontSize: isPortrait
                            ? screenWidth * 0.05
                            : screenHeight * 0.05,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Color(0xff5c9cd0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height:
                      isPortrait ? screenWidth * 0.07 : screenHeight * 0.07),
              Column(
                children: [
                  // Display favorite countries
                  CardList(
                      isDarkMode: isDarkMode,
                      favoriteCountryIds: favoriteCountries),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final bool isDarkMode;
  final List<String> favoriteCountryIds;

  const CardList(
      {Key? key, required this.isDarkMode, required this.favoriteCountryIds})
      : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  String? _selectedLanguage;
  Language _language = Language();
  List<Country> countries = [];
  List<Country> favoriteCountries = [];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadCountries();
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  _loadCountries() async {
    BlocProvider.of<AuthCubit>(context).fetchCountries();
    setState(() {
      favoriteCountries = countries
          .where((country) =>
              widget.favoriteCountryIds.contains(country.countryId.toString()))
          .toList();
    });
  }

  void _saveCountryId(int countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedCountryId', countryId);
  }

  void _toggleFavorite(int index, Country country) {
    setState(() {
      if (widget.favoriteCountryIds.contains(country.countryId.toString())) {
        widget.favoriteCountryIds.remove(country.countryId.toString());
        _removeFavoriteCountry(country);
      } else {
        widget.favoriteCountryIds.add(country.countryId.toString());
        _saveFavoriteCountry(country);
      }
      favoriteCountries = countries
          .where((country) =>
              widget.favoriteCountryIds.contains(country.countryId.toString()))
          .toList();
    });
  }

  _saveFavoriteCountry(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(country.countryId.toString());
    await prefs.setStringList('favorites', favorites);
  }

  _removeFavoriteCountry(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(country.countryId.toString());
    await prefs.setStringList('favorites', favorites);
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CountryLoaded) {
          setState(() {
            countries = state.countries;
            favoriteCountries = countries
                .where((country) => widget.favoriteCountryIds
                    .contains(country.countryId.toString()))
                .toList();
          });
        } else if (state is CountryError) {
          print('Error loading countries: ${state.message}');
        }
      },
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait ? 2 : 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: favoriteCountries.length,
        itemBuilder: (context, index) {
          Country country = favoriteCountries[index];
          bool isFavorite =
              widget.favoriteCountryIds.contains(country.countryId.toString());
          return GestureDetector(
            onTap: () {
              _saveCountryId(country.countryId); // Use country.countryId here
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Purposes(),
                ),
              );
            },
            child: Card(
              color: widget.isDarkMode ? Colors.black : Colors.white,
              shadowColor: Colors.grey,
              elevation: 5.0,
              child: Stack(
                children: [
                  Image.network(
                    country.countryImages.isNotEmpty
                        ? country.countryImages[0]
                        : 'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: widget.isDarkMode ? Colors.black : Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Column(
                        children: [
                          Text(
                            country.countryName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : Color(0xff4FACD7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            country.countryDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () => _toggleFavorite(index, country),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
