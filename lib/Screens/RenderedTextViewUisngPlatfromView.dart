import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class RenderedTextViewUsingPlatformView extends StatefulWidget {
  const RenderedTextViewUsingPlatformView({Key? key}):super(key:key);
  @override
  State<StatefulWidget> createState() => _RenderedTextViewUsingPlatformView();
}

class _RenderedTextViewUsingPlatformView extends State<RenderedTextViewUsingPlatformView>{
  final String viewType = 'hybrid-view-type';
  // platform.setMethodCallHandler((call) async{
  //   if (call.method == 'onNativeViewClick') {
  //     print('we have successfully called dart code on click of platform view in kotlin');
  //   }
  // });

  var platform = const MethodChannel('we_are_sending_data_from_kotlin_to_flutter');

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      platform.setMethodCallHandler((call) async{
        print('call.method ${call.method}');
        if (call.method == 'onNativeViewClick') {
          print('we have successfilly called dart code on click of platform view in kotlin');
        }
      });
    });

    super.initState();

  }


  final Map<String, dynamic> creationParams = <String, dynamic>{
    "name":"deep gajjar",
    "age":25,
    "gneder":"Male",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Counter using event channel"),
      ),
      body: Center(
        child: PlatformViewLink(
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
                controller: controller as AndroidViewController,
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{});
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initAndroidView(
                id: params.id,
                viewType: viewType,
                layoutDirection: TextDirection.rtl,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec()
            )..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)..create();
          },
          viewType: viewType,
        ),
      )
        );
  }
}