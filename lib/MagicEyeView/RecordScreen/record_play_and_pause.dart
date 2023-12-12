import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class PlayAndPause extends StatefulWidget {
  final VlcPlayerController vlcPlayerController;

  const PlayAndPause(this.vlcPlayerController, {super.key});

  @override
  State<PlayAndPause> createState() => _PlayAndPauseState();
}

class _PlayAndPauseState extends State<PlayAndPause> {
  bool videoPlaying = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (videoPlaying && widget.vlcPlayerController.value.isPlaying) {
            await widget.vlcPlayerController.pause();
            setState(() {
              videoPlaying = false;
            });
          } else {
            await widget.vlcPlayerController.play();
            setState(() {
              videoPlaying = true;
            });
          }
        },
        icon: Icon(
          videoPlaying && widget.vlcPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.white,
        ));
  }
}
