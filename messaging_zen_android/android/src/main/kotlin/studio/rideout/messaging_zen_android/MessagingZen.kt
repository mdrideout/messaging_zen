package studio.rideout.messaging_zen_android

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import zendesk.android.Zendesk
import zendesk.messaging.android.DefaultMessagingFactory

class MessagingZen(private val channel: MethodChannel, private val activity: Activity?) {
    private val tag: String = "[MessagingZen]"

    fun initialize(@NonNull key: String, @NonNull result: Result) {
        if (activity != null) {
            channel.invokeMethod("logger", "$tag - initializing Zendesk Messaging with key: $key")

            Zendesk.initialize(
                context = activity,
                channelKey = key,
                successCallback = { zendesk ->
                    channel.invokeMethod("logger", "$tag - Zendesk.initialize() was successful.")
                    result.success(true)
                },
                failureCallback = { zendesk ->
                    channel.invokeMethod("logger", "$tag - Zendesk.initialize() failed. ${zendesk.message}")
                    result.success(false)
                },
                messagingFactory = DefaultMessagingFactory()
            )
        } else {
            channel.invokeMethod("logger", "$tag - cannot initialize Zendesk Messaging with null activity.")
            result.success(false)
        }
    }

    fun show(@NonNull result: Result) {
        // Show the Activity
        if (activity != null) {
            channel.invokeMethod("logger", "$tag - showing Zendesk Messaging activity")

            Zendesk.instance.messaging.showMessaging(activity, Intent.FLAG_ACTIVITY_NEW_TASK)
            result.success(true)
        } else {
            channel.invokeMethod("logger", "$tag - cannot show Zendesk Messaging with null activity.")
            result.success(false)
        }
    }

}