package com.bridge;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.widget.Toast;

import com.cbdmobile.activitys.MainActivity1;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class BridgeModule extends ReactContextBaseJavaModule {
        private static ReactApplicationContext reactContext;

        private static final String DURATION_SHORT_KEY = "SHORT";
        private static final String DURATION_LONG_KEY = "LONG";
        private static Callback msgCallback;

        public BridgeModule(ReactApplicationContext context) {
        super(reactContext);
        reactContext = context;
        }


    public String getName() {
        return "ReactNativeHelper";
    }


    @ReactMethod
    public void show(String message, int duration) {
        Toast.makeText(reactContext, message, duration).show();
    }

    @ReactMethod
    public void startNewActivity(Callback callback){
        msgCallback = callback;
//        reactContext.startActivityForResult(new Intent(reactContext, MainActivity1.class),100,null);
    }

    @ReactMethod
    public void sayHello(Double tag,String msg){
        new AlertDialog.Builder(reactContext.getCurrentActivity()).setTitle("title").setMessage(msg).setPositiveButton("OK",
                new DialogInterface.OnClickListener(){

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                }
        ).setNegativeButton("Cancel",
                new DialogInterface.OnClickListener(){

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                }
        ).show();
    }

    @ReactMethod
    public void pushScreen(Double tag, String name){
        reactContext.startActivityForResult(new Intent(reactContext, MainActivity1.class),100,null);
    }

    @ReactMethod
    public void presentScreen(Double tag, String name){
        reactContext.startActivityForResult(new Intent(reactContext, MainActivity1.class),100,null);

    }


    public void sendCallbackMessage(String result) {
        msgCallback.invoke(result);
    }
}