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

class _HomePageState extends State<HomePage> {
  bool _isListening = false;
  ACRCloudResponseMusicItem? music;
  @override
  void initState() {
    ACRCloud.setUp(ACRCloudConfig(
        Constants().apiKey, Constants().apiSecret, Constants().host));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[900],
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, bottom: 48.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: RipplesAnimation(
                    color: Colors.black,
                    size: _isListening ? 160.0 : 0,
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
                    // onPrimary: AppColors.mainColor, // <-- Splash color
                  ),
                  onPressed: () async {
                    setState(() {
                      _isListening = true;
                      music = null;
                    });

                    final session = ACRCloud.startSession();

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

                    final result = await session.result;

                    if (result == null) {
                      // Cancelled.
                      if (_isListening) {
                        session.cancel;
                        setState(() {
                          _isListening = false;
                        });
                      }
                      return;
                    } else if (result.metadata == null) {
                      setState(() {
                        _isListening = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No result.'),
                      ));
                      return;
                    }

                    setState(() {
                      _isListening = false;
                      music = result.metadata!.music.first;
                    });
                  },
                ),
              )),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 8,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      music != null ? SongWidget(music: music!) : Container(),
                ),
              ),
              _isListening
                  ? Positioned(
                      top: MediaQuery.of(context).size.height / 5,
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

  void getMusic() async {
    setState(() {
      music = null;
    });

    final session = ACRCloud.startSession();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Listening...'),
        content: StreamBuilder(
          stream: session.volumeStream,
          initialData: 0,
          builder: (_, snapshot) => Text(snapshot.data.toString()),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: session.cancel,
          )
        ],
      ),
    );

    final result = await session.result;
    Navigator.pop(context);

    if (result == null) {
      // Cancelled.
      return;
    } else if (result.metadata == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No result.'),
      ));
      return;
    }

    setState(() {
      music = result.metadata!.music.first;
    });
  }
}
