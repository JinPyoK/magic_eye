import 'package:flutter/material.dart';
import 'drop_down_box.dart';
import 'package:provider/provider.dart';
import 'cctv_provider.dart';
import 'cctv_view.dart';
import 'package:magic_eye/Firebase/auth.dart';

class CCTVScreen extends StatelessWidget {
  const CCTVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CCTVProvider())],
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(builder: (_, box) {
            final width = box.maxWidth;
            final height = box.maxHeight;
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height / 25,
                      ),
                      renderMainBar(width),
                      renderIntroduce(width, getDisplayName()),
                      const SizedBox(
                        height: 20,
                      ),
                      Menu(width / 1.3),
                      const SizedBox(
                        height: 20,
                      ),
                      CCTVView(width, height),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

renderMainBar(double width) {
  return SizedBox(
    width: width / 1.2,
    height: 70,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/logo.png'),
            const SizedBox(
              width: 15,
            ),
            const Text(
              "MagicEye",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Badge(
          label: const Text("2"),
          child: GestureDetector(
            onTap: () {
              // Todo: Route to RecordScreen and set alarm text 0
            },
            child: const Icon(
              Icons.alarm,
              size: 40,
            ),
          ),
        )
      ],
    ),
  );
}

renderIntroduce(double width, String name) {
  const TextStyle textStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 26);
  return SizedBox(
    width: width / 1.2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 0, maxWidth: width / 2.5),
              child: Text(
                name,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(
              "님, 반가워요!",
              style: textStyle,
            )
          ],
        ),
        const Text(
          "어느 곳을 보실래요?",
          style: textStyle,
        ),
      ],
    ),
  );
}
