package xyz.getin.scanner

import androidx.annotation.NonNull
import xyz.getin.scanner.BuildConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "xyz.getin.scanner/channel"
        ).setMethodCallHandler { _, result ->
            result.success(BuildConfig.FLAVOR)
        }
    }
}
