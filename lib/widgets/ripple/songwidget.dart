import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:listenbox/widgets/SlideFadeTransition.dart';

class SongWidget extends StatefulWidget {
  final ACRCloudResponseMusicItem music;
  const SongWidget({Key? key, required this.music}) : super(key: key);

  @override
  _SongWidgetState createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideFadeTransition(
          delayStart: const Duration(milliseconds: 450),
          child: Text(
            widget.music.title,
            style: const TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        SlideFadeTransition(
          delayStart: const Duration(milliseconds: 900),
          child: Text(
            widget.music.album.name,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        SlideFadeTransition(
          delayStart: const Duration(milliseconds: 1350),
          child: Text(
            widget.music.artists.first.name,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
