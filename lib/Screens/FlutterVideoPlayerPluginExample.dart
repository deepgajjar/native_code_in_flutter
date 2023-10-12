import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player_plugin/flutter_video_player_plugin.dart';

class FlutterVideoPlayerPluginExample extends StatefulWidget {
  const FlutterVideoPlayerPluginExample({super.key});

  @override
  State<StatefulWidget> createState() => _FlutterVideoPlayerPluginExample();
}

class _FlutterVideoPlayerPluginExample
    extends State<FlutterVideoPlayerPluginExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("flutter plugin used made by us"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              
              child: Center(
                  child:
                      FractionallySizedBox(
                        heightFactor: 0.05,
                          widthFactor: 1,
                          child: FlutterVideoPlayerPlugin())),
            )),
          ],
        ));
  }
}
