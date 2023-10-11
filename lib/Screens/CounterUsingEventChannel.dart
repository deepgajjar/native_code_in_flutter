import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterUsingEventChannel extends StatefulWidget {
  const CounterUsingEventChannel({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CounterUsingEventChannel();
}

class _CounterUsingEventChannel extends State<CounterUsingEventChannel> {
  EventChannel eventChannel = const EventChannel("deep_gajjar_event_channel");
  int counter = 0;
  late StreamSubscription<dynamic> subscription;
  void handleEventChannel() {
    subscription = eventChannel.receiveBroadcastStream().listen((event) {
      print('event data ==>>> ${event}');
      setState(() {
        counter = event;
      });
    });
  }

  void handleCancelEventChannel() {
    // eventChannel.
    // subscription.isNull
    if (counter != 0) {
      subscription.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print(subscription.isPaused);
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter using event channel"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: handleEventChannel,
                child: const Text(
                  'send event',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 8,
            ),
            InkWell(
                onTap: handleCancelEventChannel,
                child: const Text(
                  'cancel event',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 8,
            ),
            Text('Counter ${counter}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
