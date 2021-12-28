import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:listenbox/utils/constants.dart';
import 'package:listenbox/widgets/ripple/rippleanimation.dart';
import 'package:listenbox/widgets/ripple/songwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<double> bubbleAnimation;
  late AnimationController bubbleController;
  // list of bubble widgets shown on screen
  final List<Widget> bubbleWidgets = [];
  late double _scale;
  late AnimationController _buttonController;
  double _micVolume = 0.0;

  // flag to check if the bubbles are already present or not.
  bool areBubblesAdded = false;
  bool _isListening = false;
  ACRCloudResponseMusicItem? music;
  late Object _session;
  late Stream<double> volume;
  @override
  void initState() {
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    bubbleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    bubbleAnimation = CurvedAnimation(
        parent: bubbleController, curve: Curves.easeIn)
      ..addListener(() {})
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            addBubbles(animation: bubbleAnimation, topPos: -1.001, bubbles: 2);
            bubbleController.reverse();
          });
        }
        if (status == AnimationStatus.dismissed) {
          setState(() {
            addBubbles(animation: bubbleAnimation, topPos: -1.001, bubbles: 2);
            bubbleController.forward();
          });
        }
      });

    bubbleController.forward();
    ACRCloud.setUp(ACRCloudConfig(
        Constants().apiKey, Constants().apiSecret, Constants().host));
    super.initState();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!areBubblesAdded) {
      addBubbles(animation: bubbleAnimation);
    }
    return Scaffold(
      backgroundColor: Colors.amber[900],
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: bubbleWidgets +
                [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: RipplesAnimation(
                        color: Colors.black,
                        size: _isListening ? 70 + (_micVolume * 100) : 0.0,
                        onPressed: () {
                          setState(() {
                            music = null;
                          });
                        },
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Icon(
                          Icons.headphones,
                          color: Colors.white,
                          size: 50,
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            minimumSize: const Size(50, 50),
                            tapTargetSize: MaterialTapTargetSize.padded,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            primary: Colors.black,
                            alignment: Alignment.center
                            // onPrimary: AppColors.mainColor, // <-- Splash color
                            ),
                        onPressed: () async {
                          _buttonController.forward();
                          Future.delayed(const Duration(milliseconds: 750),
                              () => {_buttonController.reverse()});

                          setState(() {
                            _isListening = true;
                            music = null;
                          });
                          ACRCloudSession session = ACRCloud.startSession();
                          setState(() {
                            _session = session;
                            session.volumeStream.listen((event) {
                              setState(() {
                                _micVolume = event;
                              });
                            });
                          });

                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (context) => AlertDialog(
                          //     title: const Text('Listening...'),
                          //     content: StreamBuilder(
                          //       stream: session.volumeStream,
                          //       initialData: 0,
                          //       builder: (_, snapshot) => Text(snapshot.data.toString()),
                          //     ),
                          //     actions: [
                          //       TextButton(
                          //         child: const Text('Cancel'),
                          //         onPressed: session.cancel,
                          //       )
                          //     ],
                          //   ),
                          // );
                          volume = session.volumeStream;

                          final result = await session.result;

                          if (result == null) {
                            // Cancelled.
                            if (_isListening) {
                              session.cancel();
                              setState(() {
                                _isListening = false;
                              });
                            }
                            return;
                          } else if (result.metadata == null) {
                            setState(() {
                              _isListening = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'We cant find any result.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ));
                            return;
                          }

                          setState(() {
                            _isListening = false;
                            music = result.metadata!.music.first;
                          });
                        },
                      ),
                    ),
                  ),
                  _isListening
                      ? Positioned(
                          bottom: MediaQuery.of(context).size.height / 8,
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Tap to cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container(),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 8,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: music != null
                          ? SongWidget(music: music!)
                          : Container(),
                    ),
                  ),
                  _isListening
                      ? Positioned(
                          top: MediaQuery.of(context).size.height / 6,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('Listening...',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : Container(),
                ],
          ),
        ),
      ),
    );
  }

  getBubbles() {
    return bubbleWidgets;
  }

  void addBubbles({animation, topPos = 0, leftPos = 0, bubbles = 15}) {
    for (var i = 0; i < bubbles; i++) {
      var range = Random();
      var minSize = range.nextInt(30).toDouble();
      var maxSize = range.nextInt(30).toDouble();
      var left = leftPos == 0
          ? range.nextInt(MediaQuery.of(context).size.width.toInt()).toDouble()
          : leftPos;
      var top = topPos == 0
          ? range.nextInt(MediaQuery.of(context).size.height.toInt()).toDouble()
          : topPos;

      var bubble = Positioned(
          left: left,
          top: top,
          child: AnimatedBubble(
              animation: animation, startSize: minSize, endSize: maxSize));

      setState(() {
        areBubblesAdded = true;
        bubbleWidgets.add(bubble);
      });
    }
  }
}

class AnimatedBubble extends AnimatedWidget {
  // A 4-Dimensional matrix to transform a bubble
  final transform = Matrix4.identity();

  // Start size of the bubble
  double startSize;
  //End size of the bubble
  double endSize;

  AnimatedBubble(
      {Key? key,
      required Animation<double> animation,
      required this.endSize,
      required this.startSize})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final _sizeTween = Tween<double>(begin: startSize, end: endSize);

    transform.translate(0.0, 0.5, 0.0);

    return Opacity(
      opacity: 0.4,
      child: Transform(
        transform: transform,
        child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          height:
              _sizeTween.evaluate(animation), //_sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          // child: const Icon(
          //   Icons.audiotrack_rounded,
          //   size: 15,
          // ), //_sizeTween.evaluate(animation),
        ),
      ),
    );
  }
}
