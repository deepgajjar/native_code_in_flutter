package com.example.native_code_in_flutter

import android.content.Context
import android.view.View
import android.widget.TextView
import androidx.annotation.Nullable
import io.flutter.plugin.platform.PlatformView

class NativeWidget(context: Context, id: Int,
                   @Nullable creationParams: Map<String?, Any?>?) : PlatformView{
    private val textView: TextView

    override fun getView(): View {
        return textView
    }

    override fun dispose() {
    }

    init {
        textView = TextView(context)
        textView.textSize = 72f
        textView.text = "Hello from Android"
    }
}