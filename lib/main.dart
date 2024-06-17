import 'package:ONATION/provider/langauge.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/loginandregisteration/main2.dart';
import 'package:ONATION/purposes.dart';
import 'package:ONATION/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ONATION/cubit/user_cubit.dart';
import 'package:ONATION/cubit/user_states.dart';

final _formKey = GlobalKey<FormState>();
Language language = Language();
String? _selectedLanguage; // Change to nullable
bool isDarkMode = false;
void main() {
  SharedPreferences.getInstance().then((instance) {
    //  bool isDarkMode = instance.getBool('darkMode') ?? false;
    _selectedLanguage = instance.getString('language') ?? 'AR';
    language =
        Language(); // Assuming Language is a class that needs to be instantiated
    language.setLanguage(_selectedLanguage!);
    runApp(
      MyApp(),
    );
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Navigationbar(isDarkMode: isDarkMode),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _Home createState() => _Home();
}

class Navigationbar extends StatefulWidget {
  final bool isDarkMode;
  Navigationbar({Key? key, required this.isDarkMode});

  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  String? countryname;
  String? countrydesc;
  String? _selectedLanguage;
  bool isDarkMode = false;
  Language _language = Language();
  void initState() {
    super.initState();
    _loadLanguage();
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
      isDarkMode = prefs.getBool('darkMode') ?? false; // Load theme mode
    });
  }

  int _selectedIndex = 1;
  final List<Widget> _pages = [
    Profile(),
    Home(),
  ];

  void _onItemTapped(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = index;
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage!);
    });
  }

  final TextEditingController _suggesstiontitleController =
      TextEditingController();
  final TextEditingController _suggesstiondescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showBoxWithTextFields(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Form key for validation

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        Widget _buildLandscapeForm(BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    _language.tsuggadd(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff4FACD7), // Set text color here
                    ),
                    textAlign: _selectedLanguage == "AR"
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Directionality(
                    textDirection: _selectedLanguage == "AR"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextFormField(
                      controller: _suggesstiontitleController,
                      decoration: InputDecoration(
                        labelText: _language.ttitlsugg(),
                        labelStyle: TextStyle(color: Color(0xff4FACD7)),
                        border: UnderlineInputBorder(), // Underline border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Directionality(
                    textDirection: _selectedLanguage == "AR"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextFormField(
                      controller: _suggesstiondescriptionController,
                      decoration: InputDecoration(
                        labelText: _language.tdessugg(),
                        labelStyle: TextStyle(color: Color(0xff4FACD7)),
                        border: UnderlineInputBorder(), // Underline border
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return _language.empssugg();
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF76DEFF),
                      ),
                      onPressed: () {
                        // Get the text field values
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).addsuggestion(
                            suggestionTitle: _suggesstiontitleController.text,
                            suggestionDescription:
                                _suggesstiondescriptionController.text,
                          );
                        }
                      },
                      child: Text(_language.tadd(),
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF76DEFF),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(_language.tcancel(),
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        Widget _buildPortraitForm(BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    _language.tsuggadd(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff4FACD7), // Set text color here
                    ),
                    textAlign: _selectedLanguage == "AR"
                        ? TextAlign.end
                        : TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Directionality(
                    textDirection: _selectedLanguage == "AR"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextFormField(
                      controller: _suggesstiontitleController,
                      decoration: InputDecoration(
                        labelText: _language.ttitlsugg(),
                        labelStyle: TextStyle(color: Color(0xff4FACD7)),
                        border: UnderlineInputBorder(), // Underline border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Directionality(
                    textDirection: _selectedLanguage == "AR"
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: TextFormField(
                      controller: _suggesstiondescriptionController,
                      validator: (value) {
                        if (_suggesstiondescriptionController.text.isEmpty) {
                          return _language.empssugg();
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: _language.tdessugg(),
                        labelStyle: TextStyle(color: Color(0xff4FACD7)),
                        border: UnderlineInputBorder(), // Underline border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF76DEFF),
                        ),
                        onPressed: () {
                          // Get the text field values
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).addsuggestion(
                              suggestionTitle: _suggesstiontitleController.text,
                              suggestionDescription:
                                  _suggesstiondescriptionController.text,
                            );
                          }
                        },
                        child: Text(_language.tadd(),
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF76DEFF),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(_language.tcancel()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              // Determine the current orientation
              final isLandscape =
                  MediaQuery.of(context).orientation == Orientation.landscape;

              if (state is AddsuggestionSuccessState) {
                // Handle success state
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                    ),
                    backgroundColor: Color(0xff4FACD7),
                    behavior: isLandscape
                        ? SnackBarBehavior.floating
                        : SnackBarBehavior.fixed,
                    width: isLandscape
                        ? screenWidth * 0.6
                        : null, // Adjust width in landscape
                  ),
                );
                Navigator.pop(context); // Close the bottom sheet on success
              } else if (state is FaliledtoAddsuggestionState) {
                // Handle failure state
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                    ),
                    backgroundColor: Colors.red,
                    behavior: isLandscape
                        ? SnackBarBehavior.floating
                        : SnackBarBehavior.fixed,
                    width: isLandscape
                        ? screenWidth * 0.6
                        : null, // Adjust width in landscape
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AddsuggestionLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    final isLandscape = orientation == Orientation.landscape;
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: isLandscape
                            ? _buildLandscapeForm(context)
                            : _buildPortraitForm(context),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: isDarkMode ? Colors.white : Color(0xff4FACD7),
        unselectedItemColor: isDarkMode ? Color(0xffe0e0e0) : Color(0xff4FACD7),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 30,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: _language.tprofile(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: _language.thome(),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBoxWithTextFields(context);
        },
        child: Icon(Icons.add, color: isDarkMode ? Colors.black : Colors.white),
        backgroundColor: isDarkMode ? Colors.white : Colors.blue,
      ),
    );
  }
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> continents = [
    'أمريكا الشمالية',
    ' أوروبا',
    'آسيا',
    'الكل',
  ];
  String _searchQuery = "";
  TextEditingController _searchController = TextEditingController();
  late String _selectedLanguage;
  Language _language = Language();
  bool isDarkMode = false;
  bool _isLoading = true; // Add this line

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    context.read<AuthCubit>().fetchCountries();
    _tabController = TabController(length: continents.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _handleTabSelection(); // Initial call to handle the initial tab selection
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final selectedContinent = continents[_tabController.index];
      print('Selected Continent: $selectedContinent');
      print('Tab Index: ${_tabController.index}');
      if (selectedContinent == 'الكل') {
        context.read<AuthCubit>().fetchCountries();
      } else {
        context.read<AuthCubit>().countriesbycontient(selectedContinent);
      }
    }
  }

  void _onSearch(title) {
    final title = _searchController.text;
    context.read<AuthCubit>().searchCountries(title);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    context.read<AuthCubit>().searchCountries(query);
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
      _language.setLanguage(_selectedLanguage);
      isDarkMode = prefs.getBool('darkMode') ?? false;
      if (_selectedLanguage == 'AR' || _selectedLanguage == 'EN') {
        _tabController.index = continents.length - 1;
      }
      _isLoading = false; // Add this line to indicate loading is complete
    });
  }

  final _formKey = GlobalKey<FormState>();

  void _toggleThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
      prefs.setBool('darkMode', isDarkMode); // Store new mode
      // Toggle dark mode boolean
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return OrientationBuilder(
            builder: (context, orientation) {
              if (_isLoading) {
                // Check if language is loading
                return Center(
                    child:
                        CircularProgressIndicator()); // Show progress indicator
              } else {
                if (orientation == Orientation.portrait) {
                  return _buildPortraitLayout();
                } else {
                  return _buildLandscapeLayout();
                }
                actions:
                [
                  IconButton(
                    icon: Icon(
                        isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                    onPressed: _toggleThemeMode,
                  ),
                ];
                body:
                Center(
                  child: Text('Dark Mode: $isDarkMode'),
                );
              }
            },
          );
        });
  }

  Widget _buildPortraitLayout() {
    List<Tab> tabs =
        continents.map((contintentname) => Tab(text: contintentname)).toList();

    // Conditionally reverse the order of tabs if the selected language is Arabic
    /*  if (_selectedLanguage == "AR") {
      tabs = tabs.reversed.toList();
    }*/
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
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
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                        //color: Colors.white.withOpacity(0.3),
                        height: 180,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'O-NATION',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .white, // Set text color based on dark mode

                                //  color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                onChanged: (query) {
                                  setState(() {
                                    _searchQuery = query;
                                  });
                                  context
                                      .read<AuthCubit>()
                                      .searchCountries(query);
                                },

                                // controller: _searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      isDarkMode ? Colors.black : Colors.white,
                                  hintText: _language.tsearch(),
                                  hintTextDirection: _selectedLanguage == 'AR'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  hintStyle: TextStyle(
                                      color: isDarkMode
                                          ? Color(0xffdedede)
                                          : Color(0xff4FACD7)),
                                  suffixIcon: _selectedLanguage == 'AR'
                                      ? IconButton(
                                          onPressed: () {
                                            /*  final title =
                                                _searchController.text;
                                            context
                                                .read<AuthCubit>()
                                                .searchCountries(title);*/
                                          },
                                          icon: Icon(Icons.search),
                                          color: isDarkMode
                                              ? Colors.grey
                                              : Color(0xff4FACD7),
                                        )
                                      : null,
                                  prefixIcon: _selectedLanguage == 'EN'
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.search),
                                          color: isDarkMode
                                              ? Colors.grey
                                              : Color(0xff4FACD7),
                                        )
                                      : null,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.blue,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Display search results
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 15),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: isDarkMode ? Colors.black : Colors.white,
                  //  labelColor: Colors.white,
                  unselectedLabelColor:
                      isDarkMode ? Colors.grey : Color(0xff4FACD7),
                  tabAlignment: TabAlignment.start,
                  automaticIndicatorColorAdjustment: true,
                  indicator: BoxDecoration(
                    color: isDarkMode ? Colors.white : Color(0xff4FACD7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tabs: tabs,
                ),
                SizedBox(height: 15),
                CardList(isDarkMode: isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    List<Tab> tabs =
        continents.map((contintentname) => Tab(text: contintentname)).toList();
    // Conditionally reverse the order of tabs if the selected language is Arabic

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: isDarkMode ? Colors.black : Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
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
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.3),
                        height: 180,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'O-NATION',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 10),
                        Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                onChanged: (query) {
                                  setState(() {
                                    _searchQuery = query;
                                  });
                                  context
                                      .read<AuthCubit>()
                                      .searchCountries(query);
                                },
                                controller: _searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: isDarkMode
                                      ? Colors.black
                                      : Colors
                                          .white, // Set text field background color based on dark mode

                                  //fillColor: Colors.white,
                                  hintText: _language.tsearch(),
                                  hintTextDirection: _selectedLanguage == 'AR'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  hintStyle: TextStyle(
                                      color: isDarkMode
                                          ? Color(0xffdedede)
                                          : Color(0xff4FACD7)),
                                  suffixIcon: _selectedLanguage == 'AR'
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.search),
                                          // Set icon color based on dark mode
                                          color: isDarkMode
                                              ? Colors.grey
                                              : Color(0xff4FACD7),
                                        )
                                      : null, // Set suffixIcon to null if language is English
                                  prefixIcon: _selectedLanguage == 'EN'
                                      ? IconButton(
                                          onPressed: () {
                                            _onSearch;
                                          },
                                          icon: Icon(Icons.search),
                                          // Set icon color based on dark mode
                                          color: isDarkMode
                                              ? Colors.grey
                                              : Color(0xff4FACD7),
                                        )
                                      : null,
                                  //suffixIconColor:
                                  //Color(0xffdedede),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.blue,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: isDarkMode ? Colors.black : Colors.white,
                  //  labelColor: Colors.white,
                  unselectedLabelColor:
                      isDarkMode ? Colors.grey : Color(0xff4FACD7),
                  tabAlignment: TabAlignment.start,
                  automaticIndicatorColorAdjustment: true,
                  indicator: BoxDecoration(
                    color: isDarkMode ? Colors.white : Color(0xff4FACD7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tabs: tabs,
                ),
                SizedBox(height: 15),
                CardListLandscape(isDarkMode: isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final bool isDarkMode;

  const CardList({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  String? _selectedLanguage;
  late List<String?> _favoriteCountryList; // Declare the list here

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _favoriteCountryList = []; // Initialize it in initState
    _loadFavoriteCountries(); // Load favorite countries
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
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

  Future<void> _loadFavoriteCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favoriteCountryList = favorites;
    });
  }

  void _toggleFavorite(int index, Country country) {
    setState(() {
      if (_favoriteCountryList.contains(country.countryId.toString())) {
        _favoriteCountryList.remove(country.countryId.toString());
        _removeFavoriteCountry(country);
      } else {
        _favoriteCountryList.add(country.countryId.toString());
        _saveFavoriteCountry(country);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is CountryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CountryError) {
          return Center(child: Text(state.message));
        } else if (state is CountryLoaded) {
          List<Country> countries = state.countries;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              bool isFavorite = _favoriteCountryList
                  .contains(countries[index].countryId.toString());
              return GestureDetector(
                onTap: () {
                  _saveCountryId(countries[index].countryId);
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
                        countries[index].countryImages.isNotEmpty
                            ? countries[index].countryImages[0]
                            : 'default_image_url',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Container(
                          color:
                              widget.isDarkMode ? Colors.black : Colors.white,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: Column(
                            children: [
                              Text(
                                countries[index].countryName,
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
                                countries[index].countryDescription,
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
                          onPressed: () =>
                              _toggleFavorite(index, countries[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _saveCountryId(int countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedCountryId', countryId);
  }
}

class CardListLandscape extends StatefulWidget {
  final bool isDarkMode;

  const CardListLandscape({Key? key, required this.isDarkMode})
      : super(key: key);

  @override
  State<CardListLandscape> createState() => _CardListLandscapeState();
}

class _CardListLandscapeState extends State<CardListLandscape> {
  String? _selectedLanguage;
  late List<String?> _favoriteCountryList;
  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _favoriteCountryList = []; // Initialize it in initState
    _loadFavoriteCountries(); // Load favorite countries
  }

  _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'AR';
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

  Future<void> _loadFavoriteCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favoriteCountryList = favorites;
    });
  }

  void _toggleFavorite(int index, Country country) {
    setState(() {
      if (_favoriteCountryList.contains(country.countryId.toString())) {
        _favoriteCountryList.remove(country.countryId.toString());
        _removeFavoriteCountry(country);
      } else {
        _favoriteCountryList.add(country.countryId.toString());
        _saveFavoriteCountry(country);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is CountryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CountryError) {
          return Center(child: Text(state.message));
        } else if (state is CountryLoaded) {
          List<Country> countries = state.countries;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              bool isFavorite = _favoriteCountryList
                  .contains(countries[index].countryId.toString());
              return GestureDetector(
                onTap: () {
                  _saveCountryId(countries[index].countryId);
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
                        countries[index].countryImages.isNotEmpty
                            ? countries[index].countryImages[0]
                            : 'default_image_url',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Container(
                          color:
                              widget.isDarkMode ? Colors.black : Colors.white,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: Column(
                            children: [
                              Text(
                                countries[index].countryName,
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
                                countries[index].countryDescription,
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
                          onPressed: () =>
                              _toggleFavorite(index, countries[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _saveCountryId(int countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedCountryId', countryId);
  }
}
