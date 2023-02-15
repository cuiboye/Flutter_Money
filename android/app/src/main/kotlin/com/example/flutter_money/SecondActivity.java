package com.example.flutter_money;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;

public class SecondActivity extends FlutterActivity implements View.OnClickListener {
    private  BasicMessageChannel<Object> basicMessageChannel;
    private Button button;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.second_activity);
        button = findViewById(R.id.button);
        button.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()){

            case R.id.button://发送消息到Flutter中
                /**
                 * 这里发送消息到Fluuter，Flutter没有接收成功，暂时不知道是什么原因
                 */
                basicMessageChannel.send("Native发送消息到Flutter中", new BasicMessageChannel.Reply<Object>() {
                    @Override
                    public void reply(@Nullable Object reply) {
                        //这里是Native发送消息到Flutter后，Flutter给Native的回执信息
//                        Log.i("loglog666","收到了Flutter的回执信息："+reply.toString());
                    }
                });
                break;
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        basicMessageChannel = new BasicMessageChannel<Object>(
                flutterEngine.getDartExecutor().getBinaryMessenger(),//Flutter引擎
                "102",//消息通道标识
                StandardMessageCodec.INSTANCE//信息编码
        );
    }
}
