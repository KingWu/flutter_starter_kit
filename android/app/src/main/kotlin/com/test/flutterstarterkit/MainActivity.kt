package com.test.flutterstarterkit

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import java.util.*


class MainActivity: FlutterActivity() {
//  private static final String CHANNEL = "samples.flutter.io/test"
  companion object {
    const val CHANNEL:String = "samples.flutter.io/test"
  }

  var channel:MethodChannel? = null
  var counter:Timer? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

//    Log.d("test", "onCreate : ")
//
//    channel = MethodChannel(flutterView, CHANNEL)
//    channel?.setMethodCallHandler { methodCall, result ->
//      Log.d("test", "methodCall.method : " + methodCall.method)
//      when (methodCall.method) {
//        "yo" -> {
//          Log.d("test", "value : " + methodCall.arguments.toString())
//          result.success("message from android")
//        }
//      }
//    }
  }

//  override fun onResume() {
//    super.onResume()
//    counter = Timer()
//
//    var result: MethodChannel.Result = object : MethodChannel.Result{
//      override fun notImplemented() {
//        Log.d("test", "notImplemented")
//      }
//
//      override fun error(p0: String?, p1: String?, p2: Any?) {
//        Log.d("test", "error")
//
//      }
//
//      override fun success(p0: Any?) {
//        Log.d("test", p0.toString())
//      }
//
//    }
//
//    counter?.scheduleAtFixedRate(timerTask {
//      channel?.invokeMethod("foo", "hello world", result)
//    }, 0, 1000)
//  }


}
