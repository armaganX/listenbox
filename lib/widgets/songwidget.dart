import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_acrcloud/flutter_acrcloud.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            SlideFadeTransition(
              delayStart: const Duration(milliseconds: 900),
              child: Container(
                height: 80,
                width: 80,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideFadeTransition(
                  delayStart: const Duration(milliseconds: 450),
                  child: Text(
                    'Song: ${widget.music.title}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SlideFadeTransition(
                  delayStart: const Duration(milliseconds: 550),
                  child: Text(
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
                  child: Text(
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
          ],
        ),
      ),
    );
  }
}
