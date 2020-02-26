package com.cbdmobile;


import android.os.Bundle;
import android.view.KeyEvent;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager.widget.ViewPager;

import com.bridge.BridgePackage;
import com.bridge.DevicePackage;
import com.cbdmobile.Fragments.DeviceListFragment;
import com.cbdmobile.Fragments.HomeFragment;
import com.cbdmobile.Fragments.SettingsFragment;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactRootView;
import com.facebook.react.common.LifecycleState;
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler;
import com.facebook.react.shell.MainReactPackage;
import com.google.android.material.tabs.TabLayout;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity implements DefaultHardwareBackBtnHandler {

    private ReactInstanceManager mReactInstanceManager;
    private ReactRootView mReactRootView;
    private List<Fragment> fragmentList = new ArrayList<Fragment>();
    private String[] titles = new String[]{"Home","Devices","Settings"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_react_use_in_fragment);

        mReactInstanceManager = ReactInstanceManager.builder()
                .setApplication(this.getApplication())
                .setBundleAssetName("index.android.bundle")
                .setJSMainModulePath("index")
                .addPackage(new MainReactPackage())
                .addPackage(new BridgePackage())
                .addPackage(new DevicePackage())
                .setCurrentActivity(this)
                .setUseDeveloperSupport(BuildConfig.DEBUG)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();
        initHomeData();
        initDeviceData();
        initView();
//        ReactUseInFragmentTwo fragment = new ReactUseInFragmentTwo();
//
//        fragment.setmReactInstanceManager(mReactInstanceManager, null);
//
//        FragmentManager fragmentManager = getSupportFragmentManager();
//        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
//        fragmentTransaction.add(R.id.fl_react, fragment).show(fragment);
//        fragmentTransaction.commit();
    }

    private void initHomeData(){
        HomeFragment homeFragment = new HomeFragment();
        Bundle bundle = new Bundle();
        Gson gson = new Gson();
//                ArrayList<String>scoresArrayList = new ArrayList<>();
        ArrayList<Score> scoresArrayList = new ArrayList<>();
        Score score1 = new Score("Alex","42");
        scoresArrayList.add(score1);
//                scoresArrayList.add(score1);
        Score score2 = new Score("Joel","10");
        scoresArrayList.add(score2);
//                scoresArrayList.add(score2);
        bundle.putString("members", gson.toJson(scoresArrayList));
        homeFragment.setmReactInstanceManager(mReactInstanceManager,bundle);
        fragmentList.add(homeFragment);



    }

    private void initDeviceData(){
        ArrayList<Device> devicesArrayList = new ArrayList<>();
        Bundle bundle = new Bundle();
        Gson gson = new Gson();
        Device device = new Device("170908616", "MDEwOlJlcG9zaXRvcnkxNzA5MDg2MTY=", ".github", "google/.github");
        devicesArrayList.add(device);
        Device device1 = new Device(
                "143044068",
                "MDEwOlJlcG9zaXRvcnkxNDMwNDQwNjg=",
                "0x0g-2018-badge",
                "google/0x0g-2018-badge");
        devicesArrayList.add(device1);
        Device device2 = new Device(
                "91820777",
               "MDEwOlJlcG9zaXRvcnk5MTgyMDc3Nw==",
               "abpackage",
                 "google/abpackage");
        devicesArrayList.add(device2);
        bundle.putString("repos", gson.toJson(devicesArrayList));
        DeviceListFragment deviceListFragment = new DeviceListFragment();
        deviceListFragment.setmReactInstanceManager(mReactInstanceManager,bundle);
        fragmentList.add(deviceListFragment);

        SettingsFragment settingsFragment = new SettingsFragment();
//        settingsFragment.setmReactInstanceManager(mReactInstanceManager,bundle);
        fragmentList.add(settingsFragment);
    }

    private void initView(){
        TabLayout tab_layout = findViewById(R.id.tab_layout);
        TabLayout.Tab tab1 = tab_layout.newTab();
        tab1.setText("Home");
        tab_layout.addTab(tab1,0);
        tab1 = tab_layout.newTab();
        tab1.setText("Devices");
        tab_layout.addTab(tab1,1);
        TabLayout.Tab tab2 = tab_layout.newTab();
        tab2.setText("Settings");
        tab_layout.addTab(tab2,2);
        ViewPager viewPager = findViewById(R.id.viewPager);
        MyAdapter fragmentAdater = new  MyAdapter(getSupportFragmentManager());
        viewPager.setAdapter(fragmentAdater);
        tab_layout.setupWithViewPager(viewPager);
    }

    public class MyAdapter extends FragmentPagerAdapter {
        public MyAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public int getCount() {
            return fragmentList.size();
        }

        @Override
        public Fragment getItem(int position) {
            return fragmentList.get(position);
        }

        @Nullable
        @Override
        public CharSequence getPageTitle(int position) {
            return titles[position];
        }
    }


    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public void invokeDefaultOnBackPressed() {
        super.onBackPressed();
    }

    @Override
    public void onPause() {
        super.onPause();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostPause(this);
        }
    }

    @Override
    public void onResume() {
        super.onResume();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostResume(this, this);
        }
    }

    @Override
    public void onBackPressed() {
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onBackPressed();
        } else {
            super.onBackPressed();
        }
    }
}
