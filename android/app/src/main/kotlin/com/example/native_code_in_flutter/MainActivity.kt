package com.example.native_code_in_flutter

import android.os.Handler
import android.os.Looper
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.OutputStream
import java.util.logging.Formatter
import java.util.logging.StreamHandler

class MainActivity: FlutterActivity() {
    val channelName : String = "deep_gajjar"
    val eventChannelName : String = "deep_gajjar_event_channel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

//        memthod channel regarding code
        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channelName)
        channel.setMethodCallHandler { call, result ->
            print("arguments ${call.arguments}")
            var arguments = call.arguments as Map<String,String>
            var msg = arguments["message"];
            if(call.method == "showToastNativeMethod"){
                Toast.makeText(this,msg,Toast.LENGTH_LONG).show()
                result.success(mutableMapOf(
                   "kotlinMsg" to "i have sent this msg from kotlin"
                ))
            }

        }

//        Event channel regarding code
        var eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger,eventChannelName)
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler{
            private val handler = Handler(Looper.getMainLooper())
            private var eventSink: EventChannel.EventSink? = null
            var r: Runnable? = null
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                events?.success("event channel integrated successfully")
                eventSink = events
                var count: Int = 0
                // every 5 second send the time
                r = object : Runnable {
                    override fun run() {
                        handler.post {
                            count ++
                            eventSink?.success(count)
                        }
                        handler.postDelayed(this, 1000)
                    }
                }
                handler.postDelayed(r as Runnable, 1000)
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
                r?.let { handler.removeCallbacks(it) }
            }
        })

//        native ui regarding code
        flutterEngine.platformViewsController.registry.registerViewFactory("hybrid-view-type",NativeWidgetFactory(flutterEngine.dartExecutor.binaryMessenger))
    }

}


