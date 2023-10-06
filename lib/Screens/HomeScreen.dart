import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var channel = const MethodChannel('deep_gajjar');
  EventChannel eventChannel = EventChannel("deep_gajjar_event_channel");
  late StreamSubscription<dynamic> subscription;

  void showToast() async {
    try {
      var getReturnedData = await channel.invokeMethod(
          "showToastNativeMethod", {"message": "msg come from flutter"});
      print('getReturnedData ===>> $getReturnedData');
    } catch (e) {
      print('catch block ...');
    }
  }

  void handleEventChannel() {
    subscription = eventChannel.receiveBroadcastStream().listen((event) {
      print('event data ==>>> ${event}');
    });
  }

  void handleCancelEventChannel() {
    // eventChannel.
    // subscription.isNull
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final String viewType = 'hybrid-view-type';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    showToast();
                  },
                  child: const Text('show toast')),
              InkWell(
                  onTap: handleEventChannel, child: const Text('send event')),
              InkWell(
                  onTap: handleCancelEventChannel,
                  child: const Text('cancel event')),
              Expanded(
                child: PlatformViewLink(
                    surfaceFactory: (context, controller) {
                      return AndroidViewSurface(
                          controller: controller as AndroidViewController,
                          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                          gestureRecognizers: const <Factory<
                              OneSequenceGestureRecognizer>>{});
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
                    viewType: viewType),
              )
            ],
          ),
        ));
  }
}
