import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cctv_provider.dart';
import 'dart:typed_data';
import 'dart:convert';

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
      context.read<CCTVProvider>().initCCTV();
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
        child: StreamBuilder<Uint8List>(
          stream: context.watch<CCTVProvider>().stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "오류 발생",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              );
            } else if (snapshot.hasData) {
              print(snapshot.data!);
              return Center(
                  child: Image.memory(
                Uint8List.fromList(base64Decode(snapshot.data!.toString())),
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      );
    });
  }
}
