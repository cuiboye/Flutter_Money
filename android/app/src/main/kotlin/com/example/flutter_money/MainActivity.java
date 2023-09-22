package com.example.flutter_money;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.logging.StreamHandler;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

//findViewById(R.id.jump).setOnClickListener(new View.OnClickListener() {
//@Override
//public void onClick(View view) {
//        Intent intent = FlutterActivity
//        .withNewEngine()
//        .initialRoute("route1")
//        .build(MainActivity.this);
//        startActivity(intent);
//        }
//        });
public class MainActivity extends FlutterActivity {
    private static final String BATTERY_CHANNEL = "samples.flutter.io/battery";
    private static final String CHARGING_CHANNEL = "samples.flutter.io/charging";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }



    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        //需要添加的插件
        registerWith(flutterEngine);

        new EventChannel(flutterEngine.getDartExecutor(), CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    private BroadcastReceiver chargingStateChangeReceiver;

                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
                        registerReceiver(chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        unregisterReceiver(chargingStateChangeReceiver);
                        chargingStateChangeReceiver = null;
                    }
                }
        );

        new MethodChannel(flutterEngine.getDartExecutor(), BATTERY_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getBatteryLevel")) {
                            int batteryLevel = getBatteryLevel();

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
        /**
         * Flutter传递数据到原生
         */
        BasicMessageChannel<Object> basicMessageChannel = new BasicMessageChannel<Object>(
          flutterEngine.getDartExecutor().getBinaryMessenger(),//Flutter引擎
          "101",//消息通道标识
                StandardMessageCodec.INSTANCE//信息编码
        );
        //设置监听  message为收到Flutter发送的消息，reply为收到消息的回执
        basicMessageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
            @Override
            public void onMessage(@Nullable Object message, @NonNull BasicMessageChannel.Reply<Object> reply) {
                Log.i("loglog666","收到Flutter传递过来的消息为："+message.toString());
                reply.reply("Flutter你好，我已经收到你发送发来的消息，消息为："+message.toString());
            }
        });

        /**
         * Flutter打开原生页面
         */
        new MethodChannel(flutterEngine.getDartExecutor(), "flutter_open_native.android").setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("openAndroidpage")) {
                            Intent intent = new Intent(MainActivity.this,SecondActivity.class);
                            startActivity(intent);

                            result.success("成功打开了第二个页面");

                            //如果这里不是跳转，而是逻辑操作，可以根据情况设置失败的情况
//                            result.error("UNAVAILABLE", "Battery level not available.", null);
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }


    private static final String TAG = "GeneratedPluginRegistrant";

    //这里是注册Flutter的插件
    public void registerWith(@NonNull FlutterEngine flutterEngine) {
        try {
            flutterEngine.getPlugins().add(new com.mix1009.android_path_provider.AndroidPathProviderPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin android_path_provider, com.mix1009.android_path_provider.AndroidPathProviderPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.spencerccf.app_settings.AppSettingsPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin app_settings, com.spencerccf.app_settings.AppSettingsPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new sk.fourq.calllog.CallLogPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin call_log, sk.fourq.calllog.CallLogPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new flutter.plugins.contactsservice.contactsservice.ContactsServicePlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin contacts_service, flutter.plugins.contactsservice.contactsservice.ContactsServicePlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.deviceinfo.DeviceInfoPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin device_info, io.flutter.plugins.deviceinfo.DeviceInfoPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin device_info_plus, dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.flutter_customappbar_plugin.FlutterCustomappbarPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin flutter_customappbar_plugin, com.flutter_customappbar_plugin.FlutterCustomappbarPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new vn.hunghd.flutterdownloader.FlutterDownloaderPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin flutter_downloader, vn.hunghd.flutterdownloader.FlutterDownloaderPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new net.jonhanson.flutter_native_splash.FlutterNativeSplashPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin flutter_native_splash, net.jonhanson.flutter_native_splash.FlutterNativeSplashPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.endigo.plugins.pdfviewflutter.PDFViewFlutterPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin flutter_pdfview, io.endigo.plugins.pdfviewflutter.PDFViewFlutterPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin fluttertoast, io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.jarvan.fluwx.FluwxPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin fluwx, com.jarvan.fluwx.FluwxPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.example.imagegallerysaver.ImageGallerySaverPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin image_gallery_saver, com.example.imagegallerysaver.ImageGallerySaverPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin permission_handler_android, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin sqflite, com.tekartik.sqflite.SqflitePlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.github.v7lin.tencent_kit.TencentKitPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin tencent_kit, io.github.v7lin.tencent_kit.TencentKitPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
        }
        try {
            flutterEngine.getPlugins().add(new io.flutter.plugins.webviewflutter.WebViewFlutterPlugin());
        } catch(Exception e) {
            Log.e(TAG, "Error registering plugin webview_flutter_android, io.flutter.plugins.webviewflutter.WebViewFlutterPlugin", e);
        }
    }

    private BroadcastReceiver createChargingStateChangeReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);

                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null);
                } else {
                    boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                            status == BatteryManager.BATTERY_STATUS_FULL;
                    events.success(isCharging ? "charging" : "discharging");
                }
            }
        };
    }

    private int getBatteryLevel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            return (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
    }
}
