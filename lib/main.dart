import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listenbox/pages/home.dart';
import 'package:listenbox/widgets/ripple/connection_status_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      home: Stack(fit: StackFit.expand, children: [
        const HomePage(),
        Align(
          alignment: Alignment.topCenter,
          child: ConnectionStatusBar(
            height: 45,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Please check your internet connection',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ],
            ),
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}
