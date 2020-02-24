package com.cbdmobile;

import android.os.Parcel;
import android.os.Parcelable;

public class Device implements Parcelable {
    private String id;
    private String node_id;
    private String name;
    private String full_name;

    public Device(String id,String node_id,String name,String full_name){
        this.node_id = node_id;
        this.id = id;
        this.name = name;
        this.full_name = full_name;
    }

    protected Device(Parcel in) {
        id = in.readString();
        node_id = in.readString();
        name = in.readString();
        full_name = in.readString();
    }

    public static final Creator<Device> CREATOR = new Creator<Device>() {
        @Override
        public Device createFromParcel(Parcel in) {
            return new Device(in);
        }

        @Override
        public Device[] newArray(int size) {
            return new Device[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(id);
        dest.writeString(node_id);
        dest.writeString(name);
        dest.writeString(full_name);
    }
}
