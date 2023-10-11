package com.example.native_code_in_flutter.videoPlayer

import android.content.Context
import android.net.Uri
import android.widget.MediaController
import android.widget.VideoView
import io.flutter.plugin.common.BinaryMessenger

class VideoPlayerKt(context:Context,creationParams: Map<String?, Any?>?,messenger: BinaryMessenger) :VideoView(context) {
    private val videoView = this
    private var autoPlay = true
    private var paused = false

    init {
//        reactContext = context as ReactContext
//        mEventDispatcher = UIManagerHelper.getEventDispatcherForReactTag(reactContext, getId())!!
        var source : String = creationParams?.get("source") as String
        videoView.setVideoURI(Uri.parse(source))
        var autoPlayFlag : Boolean? = creationParams?.get("autoPlay") as Boolean?
        this.autoPlay = autoPlayFlag != null && autoPlayFlag
        var pausedFlag : Boolean? = creationParams?.get("paused") as Boolean?
        if(pausedFlag != null && pausedFlag){
            setPaused(true)
        }else{
            setPaused(false)
        }
        val mediaController = MediaController(context)
        mediaController.setAnchorView(videoView)
        videoView.setMediaController(mediaController)
        setupListeners()
    }

    fun setAutoPlay(autoPlay: Boolean) {
        this.autoPlay = autoPlay
    }

    fun setPaused(paused: Boolean) {
        this.paused = paused
        if (videoView.canPause() && paused) {
            videoView.pause()
        } else if (!paused) {
            videoView.resume()
        }
    }

    private fun setupListeners() {
        videoView.setOnCompletionListener { mp ->
            onVideoCompleted()
        }

        videoView.setOnPreparedListener { mp ->
            onVideoLoaded()

            if (autoPlay) {
                videoView.start()
            }
        }
    }



    private fun onVideoCompleted() {
//        mEventDispatcher.dispatchEvent(CompletedEventKT(UIManagerHelper.getSurfaceId(reactContext), getId()))
    }

    private fun onVideoLoaded() {
//        mEventDispatcher.dispatchEvent(LoadedEventKT(UIManagerHelper.getSurfaceId(reactContext), getId()))
    }
}