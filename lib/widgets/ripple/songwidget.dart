import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:listenbox/widgets/SlideFadeTransition.dart';

class SongWidget extends StatefulWidget {
  final ACRCloudResponseMusicItem music;
  const SongWidget({Key? key, required this.music}) : super(key: key);

  @override
  _SongWidgetState createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color> _colorAnim;
  Color? color;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorAnim = ColorTween(begin: Colors.red, end: Colors.white)
        .animate(controller) as Animation<Color>;

    _colorAnim.addListener(() {
      setState(() {
        color = _colorAnim.value;
      });
    });

    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideFadeTransition(
          delayStart: const Duration(milliseconds: 450),
          child: Text(
            widget.music.title,
            style: TextStyle(
                fontSize: 25.0, color: color, fontWeight: FontWeight.bold),
          ),
        ),
        SlideFadeTransition(
          delayStart: Duration(milliseconds: 900),
          child: Text(
            widget.music.album.name,
            style: TextStyle(fontSize: 20.0, color: color),
          ),
        ),
        SlideFadeTransition(
          delayStart: Duration(milliseconds: 1350),
          child: Text(
            widget.music.artists.first.name,
            style: TextStyle(fontSize: 20.0, color: color),
          ),
        ),
      ],
    );
  }
}
