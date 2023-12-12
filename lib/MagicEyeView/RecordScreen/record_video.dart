import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:magic_eye/MagicEyeView/RecordScreen/record_play_button.dart';
import 'package:magic_eye/MagicEyeView/main_provider.dart';
import 'package:provider/provider.dart';

class RecordVideo extends StatefulWidget {
  final String url;

  const RecordVideo(this.url, {super.key});

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  late VlcPlayerController _vlcPlayerController;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(widget.url,
        hwAcc: HwAcc.full, options: VlcPlayerOptions());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      final width = box.maxWidth;
      final height = box.maxHeight;
      return Stack(children: [
        VlcPlayer(
          controller: _vlcPlayerController,
          aspectRatio: 16 / 9,
          placeholder: const Center(child: CircularProgressIndicator()),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context.read<MainProvider>().changeShowButton();
          },
          child: const SizedBox(
            width: 250,
            height: 200,
          ),
        ),
        context.watch<MainProvider>().showButton
            ? PlayButton(
                _vlcPlayerController,
                width,
                height,
                key: GlobalKey(),
              )
            : Container(),
      ]);
    });
  }
}
