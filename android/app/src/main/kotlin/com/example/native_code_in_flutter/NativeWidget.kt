package com.example.native_code_in_flutter

import android.content.Context
import android.os.Build
import android.view.View
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.Nullable
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import java.nio.ByteBuffer


class NativeWidget(context: Context, id: Int,
                   @Nullable creationParams: Map<String?, Any?>?,messannger:BinaryMessenger) : PlatformView,MethodCallHandler {
    private val textView: TextView
    var channel = MethodChannel(messannger,"we_are_sending_data_from_kotlin_to_flutter")
    override fun getView(): View {
        return textView
    }

    override fun dispose() {
    }
    init {
        textView = TextView(context)
        textView.textSize = 72f
        textView.text = "Hello from Android" + creationParams?.get("name") as String?

//        val callback = creationParams?.get("callback") as? (String) -> Unit
        textView.setOnClickListener(){
//            callback?.invoke(creationParams?.get("name") as String)
            channel.invokeMethod("onNativeViewClick","msg")
            Toast.makeText(context,"toast has showed on click of text",Toast.LENGTH_LONG).show()
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }
}