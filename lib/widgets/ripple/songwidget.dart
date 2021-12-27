import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';

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
        Text(
          widget.music.title,
          style: const TextStyle(
              fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.music.album.name,
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
        ),
        Text(
          widget.music.artists.first.name,
          style: const TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ],
    );
  }
}
