import 'package:flutter/material.dart';
import 'package:ONATION/loginandregisteration/haveaccount.dart';
import 'package:ONATION/loginandregisteration/main2.dart';
import 'package:ONATION/loginandregisteration/makeaccount.dart';

class Registerationway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool isPortrait = orientation == Orientation.portrait;
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              color: Colors.white,
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/whitelogo.png',
                            width: isPortrait
                                ? screenWidth * 0.05
                                : screenHeight * 0.05,
                            height: isPortrait
                                ? screenWidth * 0.05
                                : screenHeight * 0.05,
                          ),
                          SizedBox(width: screenWidth * 0.005),
                          const Text(
                            'O-NATION',
                            style: TextStyle(
                              color: Color(0xff4FACD7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: isPortrait
                            ? screenHeight * 0.01
                            : screenWidth * 0.01,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              textDirection: TextDirection.rtl,
                            ),
                            color: Colors.blue, // Icon color
                          ),
                        ],
                      ),
                      SizedBox(
                        height: isPortrait
                            ? screenHeight * 0.01
                            : screenWidth * 0.01,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'images/whitelogo.png',
                              width: isPortrait
                                  ? screenWidth * 0.3
                                  : screenHeight * 0.3,
                              height: isPortrait
                                  ? screenWidth * 0.3
                                  : screenHeight * 0.3,
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.01
                                  : screenWidth * 0.01,
                            ),
                            Text(
                              'قم بالتسجيل',
                              style: TextStyle(
                                color: Color(0xff4FACD7),
                                fontSize: isPortrait
                                    ? screenWidth * 0.07
                                    : screenHeight * 0.07,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.03
                                  : screenWidth * 0.03,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.lightBlue.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 15,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MakeAccount(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.lightBlue,
                                  backgroundColor: Color(0xff3DC9F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                    isPortrait
                                        ? screenWidth * 0.16
                                        : screenHeight * 0.16,
                                    isPortrait
                                        ? screenHeight * 0.03
                                        : screenWidth * 0.03,
                                    isPortrait
                                        ? screenWidth * 0.16
                                        : screenHeight * 0.16,
                                    isPortrait
                                        ? screenHeight * 0.03
                                        : screenWidth * 0.03,
                                  ),
                                ),
                                child: Text(
                                  ' O-NATION انشئ حساب على',
                                  style: TextStyle(
                                    fontSize: isPortrait
                                        ? screenWidth * 0.045
                                        : screenHeight * 0.045,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.035
                                  : screenWidth * 0.035,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: isPortrait
                                      ? screenWidth * 0.3
                                      : screenHeight * 0.3,
                                  height: 2,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: isPortrait
                                      ? screenWidth * 0.015
                                      : screenHeight * 0.015,
                                ),
                                Text(
                                  'او المواصلة ب',
                                  style: TextStyle(
                                    color: Color(0xff4FACD7),
                                    fontSize: isPortrait
                                        ? screenWidth * 0.03875
                                        : screenHeight * 0.03875,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  width: isPortrait
                                      ? screenWidth * 0.015
                                      : screenHeight * 0.015,
                                ),
                                Container(
                                  width: isPortrait
                                      ? screenWidth * 0.3
                                      : screenHeight * 0.3,
                                  height: 2,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.04
                                  : screenWidth * 0.04,
                            ),
                            Container(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HaveAccount(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shadowColor: Colors.lightBlue,
                                  backgroundColor: Color(0xffffffff),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: BorderSide(color: Colors.blue),
                                  padding: EdgeInsets.fromLTRB(
                                    isPortrait
                                        ? screenWidth * 0.24
                                        : screenHeight * 0.24,
                                    isPortrait
                                        ? screenHeight * 0.03
                                        : screenWidth * 0.03,
                                    isPortrait
                                        ? screenWidth * 0.24
                                        : screenHeight * 0.24,
                                    isPortrait
                                        ? screenHeight * 0.03
                                        : screenWidth * 0.03,
                                  ),
                                ),
                                child: Text(
                                  ' لديك حساب بالفعل؟',
                                  style: TextStyle(
                                    fontSize: isPortrait
                                        ? screenWidth * 0.045
                                        : screenHeight * 0.045,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff4FACD7),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isPortrait
                                  ? screenHeight * 0.035
                                  : screenWidth * 0.035,
                            ),
                            Container(
                              child: Stack(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      shadowColor: Colors.lightBlue,
                                      backgroundColor: Color(0xffffffff),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                        isPortrait
                                            ? screenWidth * 0.28
                                            : screenHeight * 0.28,
                                        isPortrait
                                            ? screenHeight * 0.03
                                            : screenWidth * 0.03,
                                        isPortrait
                                            ? screenWidth * 0.28
                                            : screenHeight * 0.28,
                                        isPortrait
                                            ? screenHeight * 0.03
                                            : screenWidth * 0.03,
                                      ),
                                    ),
                                    child: Text(
                                      ' حساب جوجل',
                                      style: TextStyle(
                                        fontSize: isPortrait
                                            ? screenWidth * 0.045
                                            : screenHeight * 0.045,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff4FACD7),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                          isPortrait
                                              ? screenWidth * 0.05
                                              : screenHeight * 0.05,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Image.asset(
                                          'images/google.png',
                                          width: isPortrait
                                              ? screenWidth * 0.08 * 2
                                              : screenHeight * 0.08 * 2,
                                          height: isPortrait
                                              ? screenWidth * 0.048
                                              : screenHeight * 0.048,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
