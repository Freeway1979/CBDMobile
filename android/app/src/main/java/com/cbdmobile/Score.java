package com.cbdmobile;


import android.os.Parcel;
import android.os.Parcelable;

public class Score implements Parcelable {
    public String name;
    public String age;
    public Score(String name, String age){
        this.name = name;
        this.age = age;
    }

    protected Score(Parcel in) {
        name = in.readString();
        age = in.readString();
    }

    public static final Creator<Score> CREATOR = new Creator<Score>() {
        @Override
        public Score createFromParcel(Parcel in) {
            return new Score(in);
        }

        @Override
        public Score[] newArray(int size) {
            return new Score[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(age);
    }

//    @NonNull
//    @Override
//    public String toString() {
//        return "{name:"+name+",age:"+age+"}";
//    }
}
