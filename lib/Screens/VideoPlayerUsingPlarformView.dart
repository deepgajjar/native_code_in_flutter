import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class VideoPlayerUsingPlatformView extends StatefulWidget{
  const VideoPlayerUsingPlatformView({Key? key}):super(key:key);
  @override
  State<StatefulWidget> createState() => _VideoPlayerUsingPlatformView();
}

class _VideoPlayerUsingPlatformView extends State<VideoPlayerUsingPlatformView>{
  var onVideoLoad = const MethodChannel('videoPlayerChannel');
  // var onVideoEnds = const MethodChannel('onVideoEnd');
  final String viewType = 'video_player_kotlin';
  final Map<String, dynamic> creationParams = <String, dynamic>{
    "source":"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "autoPlay":true,
    "paused":false,
  };

  void onVideoLoadHandler(){
  print('video has been loaded and started..... ');
  }

  void onVideoEndHandler(){
  print('video has been ended.');
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onVideoLoad.setMethodCallHandler((call) async {
        switch(call.method){
          case 'onVideoLoad':
            onVideoLoadHandler();
          break;
          case 'onVideoEnd':
            onVideoEndHandler();
          break;
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text("Counter using event channel"),
        ),
        body: Center(
          child: SizedBox(
            height:   200,
            width:300,
            child: PlatformViewLink(
              surfaceFactory: (context, controller) {
                return AndroidViewSurface(
                    controller: controller as AndroidViewController,
                    hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                    gestureRecognizers:  const <Factory<OneSequenceGestureRecognizer>>{});
              },
              onCreatePlatformView: (params) {
                return PlatformViewsService.initSurfaceAndroidView(
                    id: params.id,
                    viewType: viewType,
                    layoutDirection: TextDirection.rtl,
                    creationParams: creationParams,
                    creationParamsCodec: const StandardMessageCodec()
                )..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)..create();
              },
              viewType: viewType,
            ),
          ),
        )
    );
  }
}