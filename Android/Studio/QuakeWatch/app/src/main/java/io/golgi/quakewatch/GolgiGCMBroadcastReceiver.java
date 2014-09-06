package io.golgi.quakewatch;

import android.content.Context;
import android.content.Intent;

/**
 * Created by brian on 8/27/14.
 */

public class GolgiGCMBroadcastReceiver extends io.golgi.apiimpl.android.GolgiGCMBroadcastReceiver{

    public GolgiGCMBroadcastReceiver(){
        super("io.golgi.quakewatch", "io.golgi.quakewatch.GolgiGCMIntentService");
        DBG.write("Received PUSH");
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        DBG.write("Received PUSH(2)");
        QWService.startService(context);
        super.onReceive(context, intent);
        DBG.write("Received PUSH(3)");
    }

}
