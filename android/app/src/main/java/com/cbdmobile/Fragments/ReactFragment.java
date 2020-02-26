package com.cbdmobile.Fragments;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactRootView;

public abstract class ReactFragment extends Fragment {

    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;
    private Bundle mBundle;

    // This method returns the name of our top-level component to show
    public abstract String getMainComponentName();

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        mReactRootView = new ReactRootView(context);
    }

    public void setmReactInstanceManager(ReactInstanceManager mReactInstanceManager, Bundle bundle) {
        this.mReactInstanceManager = mReactInstanceManager;
        mBundle = bundle;
    }

    @Override
    public ReactRootView onCreateView(LayoutInflater inflater, ViewGroup group, Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        return mReactRootView;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        if(mReactRootView.getReactInstanceManager()==null){
        mReactRootView.startReactApplication(
                mReactInstanceManager,
                getMainComponentName(),
                mBundle
        );
        }
    }
}
