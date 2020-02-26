package com.bridge;

import androidx.annotation.NonNull;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class DevicePackage implements ReactPackage {
    private DeviceModule DeviceModule;
    @NonNull
    public List<NativeModule> createNativeModules(@NonNull ReactApplicationContext reactContext) {
        List<NativeModule> modules = new ArrayList();
        DeviceModule = new DeviceModule(reactContext);
        modules.add(DeviceModule);

        return modules;
    }

    @NonNull
    public List<ViewManager> createViewManagers(@NonNull ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }

    public DeviceModule getDeviceModule() {
        return DeviceModule;
    }
}
