import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_play_and_pause.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatefulWidget {
  final VlcPlayerController vlcPlayerController;
  final double width;
  final double height;

  const PlayButton(this.vlcPlayerController, this.width, this.height,
      {super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          setState(() {
            opacity = 0;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            context.read<MainProvider>().changeShowButton();
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height / 1.2,
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: PlayAndPause(widget.vlcPlayerController),
          ),
        ),
      ),
    );
  }
}
