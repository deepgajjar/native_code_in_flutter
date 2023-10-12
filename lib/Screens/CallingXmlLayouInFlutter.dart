import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CallingXmlLayoutInFlutter extends StatefulWidget{
  const CallingXmlLayoutInFlutter({Key? key}):super(key:key);
  @override
  State<StatefulWidget> createState() => _CallingXmlLayoutInFlutter();

}

class _CallingXmlLayoutInFlutter extends State<CallingXmlLayoutInFlutter>{
  final String viewType = 'xml_layout_for_flutter';
  final Map<String, dynamic> creationParams = <String, dynamic>{};
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