import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:listenbox/Server/ServerManager.dart';
import 'package:listenbox/models/DeezerSongModel.dart';
import 'package:listenbox/widgets/SlideFadeTransition.dart';

class SongWidget extends StatefulWidget {
  final ACRCloudResponseMusicItem music;
  const SongWidget({super.key, required this.music});

  @override
  SongWidgetState createState() => SongWidgetState();
}

class SongWidgetState extends State<SongWidget> {
  final ServerManager _serverManager = ServerManager();
  DeezerSongModel? _model;
  @override
  void initState() {
    super.initState();
    String id = widget.music.id;
    getData(id);
  }

  getData(String trackId) async {
    await _serverManager
        .getApiRequestDataResponse(
      endPoint: 'track/$trackId',
      fromJson: DeezerSongModel.fromJson,
      // params: {'': trackId}
    )
        .catchError((onError) {
      return onError;
    }).then((responseValue) {
      setState(() {
        _model = responseValue.data!;
      });
      if (kDebugMode) {
        print(responseValue.data!.album!.coverMedium);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          children: [
            Row(
              children: [
                SlideFadeTransition(
                  delayStart: const Duration(milliseconds: 900),
                  child: Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(10),
                        image: _model != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _model?.album?.coverMedium ?? '',
                                ),
                              )
                            : null),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideFadeTransition(
                        delayStart: const Duration(milliseconds: 450),
                        child: TextScroll(
                          'Song: ${widget.music.title}', selectable: true,
                          // mode: TextScrollMode.endless,
                          // numberOfReps: 200,
                          // delayBefore: const Duration(milliseconds: 2000),
                          // pauseBetween: const Duration(milliseconds: 1000),
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(75, 0)),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SlideFadeTransition(
                        delayStart: const Duration(milliseconds: 550),
                        child: TextScroll(
                          selectable: true,
                          // mode: TextScrollMode.endless,
                          // numberOfReps: 200,
                          // delayBefore: const Duration(milliseconds: 2000),
                          // pauseBetween: const Duration(milliseconds: 1000),
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(75, 0)),
                          textAlign: TextAlign.left,
                          'Album: ${widget.music.album.name}',
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SlideFadeTransition(
                        delayStart: const Duration(milliseconds: 650),
                        child: TextScroll(
                          selectable: true,
                          // mode: TextScrollMode.endless,
                          // numberOfReps: 200,
                          // delayBefore: const Duration(milliseconds: 2000),
                          // pauseBetween: const Duration(milliseconds: 1000),
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(75, 0)),
                          textAlign: TextAlign.left,
                          'Artist: ${widget.music.artists.first.name}',
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: const Text('Open Spotify'),
              onTap: () async {
                String url =
                    "https://open.spotify.com/intl-tr/track/${_model!.id.toString()}";
                // final spotifyUrl =
                //     'https://open.spotify.com/playlist/37i9dQZF1DWX5ZOsG2Ogi1?si=41c6a392cf7d4a2b';
                Uri link = Uri.parse(url);
                // Check if Spotify is installed
                if (await canLaunchUrl(link)) {
                  // Launch the url which will open Spotify
                  await launchUrl(link);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
