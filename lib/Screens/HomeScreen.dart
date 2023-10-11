import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_code_in_flutter/Screens/CounterUsingEventChannel.dart';
import 'package:native_code_in_flutter/Screens/RenderedTextViewUisngPlatfromView.dart';
import 'package:native_code_in_flutter/Screens/VideoPlayerUsingPlarformView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var channel = const MethodChannel('deep_gajjar');

  void showToast() async {
    try {
      var getReturnedData = await channel.invokeMethod(
          "showToastNativeMethod", {"message": "msg come from flutter"});
      print('getReturnedData ===>> $getReturnedData');
    } catch (e) {
      print('catch block ...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    showToast();
                  },
                  child: const Text('show toast using method channel',
                      style: TextStyle(fontSize: 20))),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const CounterUsingEventChannel();
                      },
                    ));
                  },
                  child: const Text(
                    'Event channel example',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const RenderedTextViewUsingPlatformView();
                      },
                    ));
                  },
                  child: const Text('hybrid composition platform view example',
                      style: TextStyle(fontSize: 20))),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const VideoPlayerUsingPlatformView();
                      },
                    ));
                  },
                  child: const Text('hybrid composition video player',
                      style: TextStyle(fontSize: 20)))
            ],
          ),
        ));
  }
}
