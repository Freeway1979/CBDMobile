package com.cbdmobile.activitys;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.cbdmobile.Score;
import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;
import com.facebook.react.ReactRootView;
import com.google.gson.Gson;

import java.util.ArrayList;

public class HomeActivity extends ReactActivity {

    /**
     * Returns the name of the main component registered from JavaScript. This is used to schedule
     * rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "RNHome";
    }


    @Override
    protected ReactActivityDelegate createReactActivityDelegate() {
        return new ReactActivityDelegate(this, getMainComponentName()){
            @Nullable
            @Override
            protected Bundle getLaunchOptions() {
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


                return bundle;
            }

            @Override
            protected ReactRootView createRootView() {
                return new ReactRootView(getContext());
            }
        };
    }
}
