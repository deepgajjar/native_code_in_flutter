package com.example.native_code_in_flutter.videoPlayer

import android.content.Context
import android.view.View
import android.widget.VideoView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class VideoPlayerPlatformView(context:Context,id:Int,creationParams: Map<String?,Any?>?,messenger:BinaryMessenger):PlatformView {
    private val videoView:VideoView = VideoPlayerKt(context,creationParams,messenger)
    override fun getView(): View? {
        return videoView
    }

    override fun dispose() {
    }
}