package io.golgi.quakewatch;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import com.openmindnetworks.golgi.api.GolgiAPI;
import com.openmindnetworks.golgi.api.GolgiAPIHandler;

import java.text.DateFormat;
import java.util.Date;

import io.golgi.apiimpl.android.GolgiService;
import io.golgi.quakewatch.gen.GolgiKeys;
import io.golgi.quakewatch.gen.QuakeDetails;
import io.golgi.quakewatch.gen.QuakeWatchService;
import io.golgi.quakewatch.gen.QuakeWatchService.*;

/**
 * Created by brian on 8/27/14.
 */
public class QWService extends GolgiService {
    public static final int MAX_TILES = 100;
    private static Object syncObj = new Object();
    private static QWService theInstance;
    private static QWActivity qwActivity;
    private DateFormat dateFormat;

    private static void DBG(String str){
        DBG.write("SVC", str);
    }

    private static QWService getTheInstance(){
        synchronized(syncObj){
            return theInstance;
        }
    }

    public static void setQWActivity(QWActivity activity){
        synchronized(syncObj) {
            qwActivity = activity;
        }
    }

    public static boolean isRunning(Context context) {
        return  GolgiService.isRunning(context,QWService.class.getName());
    }


    public static void startService(Context context){
        GolgiService.startService(context, QWService.class.getPackage().getName(), QWService.class.getName());
    }

    public static void stopService(Context context){
        GolgiService.stopService(context, QWService.class.getPackage().getName(), QWService.class.getName());
    }

    private class LocLsnr implements  QWLocationHandler.LocationListener{
        private QuakeDetails qDetails;


        @Override
        public void locationSetupError(String txt) {
            DBG.write("Location Setup Error: '" + txt + "'");
        }

        @Override
        public void locationSetupOk() {
            DBG.write("Location Setup OK");
        }

        @Override
        public void locationReady(double lat, double lng) {
            DBG.write("Location: " + lat + "/" + lng);

            double distance = LocHelper.calcDistance(lat, lng, qDetails.getLat(), qDetails.getLng());
            String bearing = LocHelper.getBearingAsString(lat, lng, qDetails.getLat(), qDetails.getLng());
            DBG.write("Bearing: " + bearing);
            DBG.write("Distance: " + distance + " km");

            if(dateFormat == null){
                dateFormat = android.text.format.DateFormat.getDateFormat(context);
            }
            Date myDate = new Date((long)qDetails.getTimestamp() * 1000);
            String dstr = dateFormat.format(myDate).toString() + android.text.format.DateFormat.format(" - h:mmaa", myDate).toString();


            String title = "M " + qDetails.getMag() + " Earthquake " + distance + " Km " + bearing + "";

            QWActivity.addEarthquake(QWService.this, dstr + " " + distance + " Km " + bearing + " " + qDetails.getTitle());

            double threshold = (double)QWActivity.getNotificationThreshold(QWService.this);

            if(qDetails.getMag() >= threshold) {
                Intent notificationIntent = new Intent(context, QWActivity.class);

                notificationIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);

                PendingIntent intent = PendingIntent.getActivity(context, 0, notificationIntent, 0);


                Notification n = new Notification.Builder(QWService.this)
                        .setContentTitle(title)
                        .setContentText(qDetails.getTitle())
                        .setSmallIcon(R.drawable.ic_stat_quake)
                                // .setSmallIcon(R.drawable.icon)
                        .setContentIntent(intent)
                        .setAutoCancel(true)
                                // .addAction(R.drawable.icon, "Call", pIntent)
                                // .addAction(R.drawable.icon, "More", pIntent)
                                // .addAction(R.drawable.icon, "And more", pIntent)
                        .build();

                n.defaults |= Notification.DEFAULT_VIBRATE | Notification.FLAG_AUTO_CANCEL;


                NotificationManager notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
                notificationManager.notify("Quake", 2468, n);
            }


        }

        @Override
        public void locationError(String txt) {
            DBG.write("LocationError: '" + txt + "'");
        }

        LocLsnr(QuakeDetails qDetails){
            this.qDetails = qDetails;
            new QWLocationHandler(QWService.this, this);
        }
    }

    private quakeAlert.RequestReceiver inboundQuakeAlert = new quakeAlert.RequestReceiver(){
        @Override
        public void receiveFrom(quakeAlert.ResultSender resultSender, QuakeDetails qDetails) {
            DBG.write("Received Quake Alert: " + qDetails.getTitle());


            new LocLsnr(qDetails);


            resultSender.success();
        }
    };

    public void registerGolgi(String id) {
        quakeAlert.registerReceiver(inboundQuakeAlert);
        GolgiAPI.getInstance().register(
                GolgiKeys.DEV_KEY,
                GolgiKeys.APP_KEY,
                id,
                new GolgiAPIHandler() {
                    @Override
                    public void registerSuccess(){
                        DBG("Golgi registration Success");
                        if(qwActivity != null) {
                            qwActivity.golgiRegistrationComplete(true);
                        }
                    }

                    @Override
                    public void registerFailure() {
                        DBG("Golgi registration Failure");
                        if(qwActivity != null) {
                            qwActivity.golgiRegistrationComplete(false);
                        }
                    }
                }
        );
    }



    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        theInstance = this;
        DBG("onStartCommand() called");
        super.onStartCommand(intent, flags, startId);
        DBG("onStartCommand() complete");

        String id = QWActivity.getGolgiId(getApplicationContext());
        registerGolgi(id);
        DBG("Registering with Golgi as '" + id + "'");

        return START_STICKY;

    }

    @Override
    public void onCreate(){
        synchronized(syncObj){
            theInstance = this;
        }

        super.onCreate();
        DBG.write("Creating Location Handler");
    }

    @Override
    public void onDestroy(){
        super.onDestroy();
        synchronized(theInstance){
            theInstance = null;
        }
    }
}
