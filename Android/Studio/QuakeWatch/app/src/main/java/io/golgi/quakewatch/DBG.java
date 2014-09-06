package io.golgi.quakewatch;

import android.util.Log;

/**
 * Created by brian on 8/27/14.
 */
public class DBG {
    public static void write(String where, String str){
        Log.i(where, str);
    }

    public static void write(String str){
        write("QW", str);
    }

}
