package com.bridge;

import android.app.AlertDialog;
import android.content.DialogInterface;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class DeviceModule extends ReactContextBaseJavaModule {
        private static ReactApplicationContext reactContext;

        private static Callback msgCallback;

        public DeviceModule(ReactApplicationContext context) {
        super(reactContext);
        reactContext = context;
        }


    public String getName() {
        return "DeviceListManager";
    }


    @ReactMethod
    public void startNewActivity(Callback callback){
        msgCallback = callback;
//        reactContext.startActivityForResult(new Intent(reactContext, MainActivity1.class),100,null);
    }

    @ReactMethod
    public void popMessage(Double tag,String msg,Callback callback){
        new AlertDialog.Builder(reactContext.getCurrentActivity()).setMessage(msg).setPositiveButton("OK",
                new DialogInterface.OnClickListener(){

                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        callback.invoke(200,"ok");
                    }
                }

        ).show();

    }



    public void sendCallbackMessage(String result) {
        msgCallback.invoke(result);
    }
}