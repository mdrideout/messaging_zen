package studio.rideout.messaging_zen_android

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import androidx.annotation.Nullable

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MessagingZenAndroidPlugin */
class MessagingZenAndroidPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private val tag: String = "[MessagingZenAndroidPlugin]"
  private lateinit var channel: MethodChannel
  var activity: Activity? = null

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val callMethod: String = call.method
    val arguments = call.arguments as Map<*, *>?
    val messagingZen = MessagingZen(channel, activity)

    when (callMethod) {
      "initialize" -> {
        channel.invokeMethod("logger", "$tag - calling messagingZen.initialize()")
        val key: String = (arguments?.get("key") ?: "") as String

        // Pass the result callback to messagingZen
        messagingZen.initialize(key, result)
      }
      "show" -> {
        channel.invokeMethod("logger", "$tag - calling messagingZen.show()")

        // Pass the result callback to messagingZen
        messagingZen.show(result)
      }
      else -> {
        channel.invokeMethod("logger", "$tag - Called unimplemented method")
        result.notImplemented()
      }
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugins.flutter.io/messaging_zen_android")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
