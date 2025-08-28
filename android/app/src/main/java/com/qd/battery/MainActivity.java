package com.qd.battery;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "zalo_share";
   // @Override
    // protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    //     super.onActivityResult(requestCode, resultCode, data);
    //     ZaloSDK.Instance.onActivityResult(this, requestCode, resultCode, data); // Add this line
    // }
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("shareImageToZalo")) {
                        String path = call.argument("path");
                        if (path != null) {
                            shareImageToZalo(path);
                            result.success(true);
                        } else {
                            result.error("INVALID_PATH", "Path is null", null);
                        }
                    }
                });
    }

    private void shareImageToZalo(String imagePath) {
        try {
            File file = new File(imagePath);
            Uri uri = FileProvider.getUriForFile(this, getPackageName() + ".fileprovider", file);

            Intent shareIntent = new Intent(Intent.ACTION_SEND);
            shareIntent.setType("image/*");
            shareIntent.putExtra(Intent.EXTRA_STREAM, uri);
            shareIntent.setPackage("com.zing.zalo");
            shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            startActivity(Intent.createChooser(shareIntent, "Share to Zalo"));
        } catch (Exception e) {
            Log.e("ZaloShare", "Share failed: " + e.getMessage());
        }
    }
}
