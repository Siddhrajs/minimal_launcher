package com.example.minimal_launcher

import android.app.WallpaperManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.example.wallpaper"
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getWallpaperPath") {
                val wallpaperPath = getWallpaperPath()
                result.success(wallpaperPath)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getWallpaperPath(): String? {
        val context: Context = applicationContext
        val wallpaperManager = WallpaperManager.getInstance(context)
        print(wallpaperManager)
        return ""
    }
}

