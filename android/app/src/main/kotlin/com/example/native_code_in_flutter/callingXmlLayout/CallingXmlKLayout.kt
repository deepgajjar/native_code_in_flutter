package com.example.native_code_in_flutter.callingXmlLayout

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.Toast
import androidx.annotation.Nullable
import com.example.native_code_in_flutter.R
import io.flutter.plugin.platform.PlatformView

class CallingXmlKLayout(context:Context,id:Int,@Nullable creationParams: Map<String?, Any?>?) : PlatformView{
    private val xmlView : View = LayoutInflater.from(context).inflate(R.layout.native_layou_view,null)
    override fun getView(): View? {
       return xmlView
    }

    init {
//        my_btn_1
        var button : Button = xmlView.findViewById(R.id.my_btn_1)
        button.setOnClickListener(){
            Toast.makeText(context,"button clicked.",Toast.LENGTH_LONG).show()
        }
    }

    override fun dispose() {
    }

}