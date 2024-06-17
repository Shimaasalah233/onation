import 'package:ONATION/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ONATION/loginandregisteration/registerationway.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

String language = 'En';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    language = instance.getString('language') ?? language;
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Splash Screen Example',
        // Specify the splash screen as the home screen
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Duration for displaying the splash screen
  final splashDuration = Duration(seconds: 2);

  // Perform any initialization tasks here, if needed

  @override
  void initState() {
    super.initState();
    // After the splash duration, navigate to the main screen
    Future.delayed(splashDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the splash screen
    return Scaffold(
      backgroundColor: const Color(0xFF76DEFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/bluelogo.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'O-NATION',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > constraints.maxHeight) {
              // Landscape orientation
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Image.asset(
                        'images/whitelogo.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'O-NATION مرحبا بك في',
                        style: TextStyle(
                          color: Color(0xff4FACD7),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Container(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registerationway(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            // primary: Colors.white,
                            elevation: 8.0,
                            backgroundColor: Color(0xff3DC9F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            side: BorderSide(color: Colors.blue),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.2,
                              MediaQuery.of(context).size.height * 0.02,
                              MediaQuery.of(context).size.width * 0.2,
                              MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                          child: Text(
                            'التالي',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      // Add the theme switch button

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                    ],
                  ),
                ),
              );
            } else {
              // Portrait orientation
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Image.asset(
                        'images/whitelogo.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'O-NATION مرحبا بك في',
                        style: TextStyle(
                          color: Color(0xff4FACD7),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Container(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registerationway(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            //  primary: Colors.white,
                            elevation: 8.0,
                            backgroundColor: Color(0xff3DC9F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            side: BorderSide(color: Colors.blue),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.2,
                              MediaQuery.of(context).size.height * 0.02,
                              MediaQuery.of(context).size.width * 0.2,
                              MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                          child: Text(
                            'التالي',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
