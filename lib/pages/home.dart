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
  bool _isLoading = false;
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RipplesAnimation(
              color: Colors.black,
              size: _isLoading ? 160.0 : 40,
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
            ElevatedButton(
              child: const Icon(
                Icons.headphones,
                color: Colors.white,
                size: 50,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.padded,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(0),
                primary: Colors.black,
                // onPrimary: AppColors.mainColor, // <-- Splash color
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
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
                setState(() {
                  _isLoading = false;
                });
                // Navigator.pop(context);

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
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: music != null ? SongWidget(music: music!) : Container(),
            )
          ],
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
