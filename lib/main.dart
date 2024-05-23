import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:listenbox/pages/HomePage.dart';
// import 'package:listenbox/widgets/connection_status_bar.dart';
import 'package:listenbox/widgets/ripple/rippleanimation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false, home: Splash());
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              // home: const HomePage(),
              home: const Stack(fit: StackFit.expand, children: [
                HomePage(),
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: ConnectionStatusBar(
                //     height: 25,
                //     title: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Icon(
                //           Icons.wifi_off_rounded,
                //           color: Colors.white,
                //           size: 25,
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Text(
                //           'Please check your internet connection',
                //           style: TextStyle(
                //               decoration: TextDecoration.none,
                //               color: Colors.white,
                //               fontSize: 14),
                //         ),
                //       ],
                //     ),
                //     color: Colors.black,
                //   ),
                // )
              ]),
            );
          }
        });
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _startSize = 0.0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(milliseconds: 150), (timer) {
        setState(() {
          _startSize += 25;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool lightMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: const Color(0xfff19b3b),
      body: Stack(alignment: Alignment.center, children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AnimatedContainer(
              height: _startSize,
              width: _startSize,
              duration: const Duration(milliseconds: 150),
              curve: Curves.linear,
              child: RippleAnimation(
                color: Colors.orange[800] as Color,
                size: 100,
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  height: 120,
                  width: 120,
                ),
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.headphones_rounded,
                  color: Colors.black,
                  size: 105.0,
                ),
                Text(
                  'ListenBox',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 3));
  }
}
