import 'package:contact/Views/home_page.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Lottie.asset('assets/images/visa.json'),
                  Text(
                    "Welcome to Visa Contacts",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        color: kVisaBlue),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Connect with all your friends who are on the visa network",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kVisaBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: displaySize(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: displaySize(context).width - 70,
                    height: 60,
                    child: Semantics(
                      enabled: true,
                      label: "Get Started button, tap to enter the app",
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: FittedBox(
                          child: Text(
                            "Get Started",
                            // semanticsLabel:
                            //     "Get Started button, tap to enter the app",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kVisaBlue,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kVisaGold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
