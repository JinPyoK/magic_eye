import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';

class CCTVView extends StatefulWidget {
  final BuildContext context;
  final double width;
  final double height;

  const CCTVView(this.context, this.width, this.height, {super.key});

  @override
  State<CCTVView> createState() => _CCTVViewState();
}

class _CCTVViewState extends State<CCTVView> {

  @override
  void initState() {
    super.initState();
    context
        .read<MainProvider>()
        .videoPlayerController
        .initialize();
  }

  @override
  Widget build(BuildContext context) {
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
      child: context
          .watch<MainProvider>()
          .menu
          .isNotEmpty
          ? VlcPlayer(
        controller: context
            .watch<MainProvider>()
            .videoPlayerController,
        aspectRatio: 16 / 9,
        placeholder: const Center(child: CircularProgressIndicator()),
      )
          : Container(),
    );
  }
}
