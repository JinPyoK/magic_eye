import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';

class PlayAndPause extends StatefulWidget {
  final VlcPlayerController vlcPlayerController;
  final String url;

  const PlayAndPause(this.vlcPlayerController, this.url, {super.key});

  @override
  State<PlayAndPause> createState() => _PlayAndPauseState();
}

class _PlayAndPauseState extends State<PlayAndPause> {
  bool videoPlaying = true;
  bool canTouch = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (canTouch) {
            canTouch = false;
            if (videoPlaying && widget.vlcPlayerController.value.isPlaying) {
              await widget.vlcPlayerController.pause();
              setState(() {
                videoPlaying = false;
              });
            } else {
              if (widget.vlcPlayerController.value.isEnded) {
                context.read<MainProvider>().changeShowButton();
                await widget.vlcPlayerController
                    .setMediaFromNetwork(widget.url);
              } else {
                await widget.vlcPlayerController.play();
                setState(() {
                  videoPlaying = true;
                });
              }
            }
            canTouch = true;
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
