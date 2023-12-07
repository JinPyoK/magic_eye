import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:magic_eye/MagicEyeView/CCTVScreen/cctv_provider.dart';
import 'package:provider/provider.dart';

class CCTVView extends StatefulWidget {
  final double width;
  final double height;

  const CCTVView(this.width, this.height, {super.key});

  @override
  State<CCTVView> createState() => _CCTVViewState();
}

class _CCTVViewState extends State<CCTVView> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<CCTVProvider>().videoPlayerController.initialize();
      return Container(
        width: widget.width / 1.3,
        height: widget.height / 2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: context.watch<CCTVProvider>().menu.isNotEmpty
            ? VlcPlayer(
                controller: context.watch<CCTVProvider>().videoPlayerController,
                aspectRatio: 16 / 9,
                placeholder: const Center(child: CircularProgressIndicator()),
              )
            : Container(),
      );
    });
  }
}
