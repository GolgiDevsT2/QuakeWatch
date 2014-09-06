package io.golgi.quakewatch;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.openmindnetworks.golgi.api.GolgiAPI;
import com.openmindnetworks.golgi.api.GolgiException;
import com.openmindnetworks.golgi.api.GolgiTransportOptions;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

import io.golgi.quakewatch.gen.QuakeFilter;
import io.golgi.quakewatch.gen.QuakeWatchService;


public class QWActivity extends Activity {
    private GolgiTransportOptions stdGto;
    private boolean inFg;
    private TextView logTv;
    private TextView nfnThresholdTv;
    private ScrollView scrollView;
    private SeekBar nfnSb;


    private static SharedPreferences getSharedPrefs(Context context){
        return context.getSharedPreferences("QuakeWatch", Context.MODE_PRIVATE);
    }

    String getQuakeLog(){
        SharedPreferences sharedPrefs = getSharedPrefs(this);
        return sharedPrefs.getString("QUAKE-LOG", "");
    }

    public static void addEarthquake(Context context, String txt){
        SharedPreferences sharedPrefs = getSharedPrefs(context);
        DBG.write("Adding '" + txt + "'");
        String logTxt =  sharedPrefs.getString("QUAKE-LOG", "");
        StringTokenizer stk = new StringTokenizer(logTxt, "\n");

        ArrayList<String> logEntries = new ArrayList<String>();
        while(stk.hasMoreTokens()){
            logEntries.add(stk.nextToken());
        }
        logEntries.add(txt);

        while(logEntries.size() > 50){
            logEntries.remove(0);
        }

        StringBuffer sb = new StringBuffer();
        for(Iterator<String> it = logEntries.iterator(); it.hasNext();){
            sb.append(it.next() + "\n");
        }

        sharedPrefs.edit().putString("QUAKE-LOG", sb.toString()).commit();

        if(logHandler != null){
            logHandler.sendEmptyMessage(0);
        }
    }

    public static int getNotificationThreshold(Context context) {
        SharedPreferences sharedPrefs = getSharedPrefs(context);
        return sharedPrefs.getInt("QUAKE-THRESHOLD", 0);
    }

    public void setNotificationThreshold(Context context, int value){
        SharedPreferences sharedPrefs = getSharedPrefs(context);
        sharedPrefs.edit().putInt("QUAKE-THRESHOLD", value).commit();
    }


    public static String getGolgiId(Context context){
        SharedPreferences sharedPrefs = getSharedPrefs(context);
        String golgiId =  sharedPrefs.getString("GOLGI-ID", "");

        if(golgiId.length() == 0){
            StringBuffer sb = new StringBuffer();
            for(int i = 0; i < 20; i++){
                sb.append((char)('A' + (int)(Math.random() * ('z' - 'A'))));
            }

            golgiId = sb.toString();
            sharedPrefs.edit().putString("GOLGI-ID", golgiId).commit();
        }
        return golgiId;
    }

    private void registerForAlerts(){
        QuakeFilter qf = new QuakeFilter(true);
        qf.setGolgiId(getGolgiId(this));

        QuakeWatchService.addMe.sendTo(
                new QuakeWatchService.addMe.ResultReceiver() {
                    @Override
                    public void failure(GolgiException ex) {
                        DBG.write("register with server failed");
                    }

                    @Override
                    public void success() {
                        DBG.write("register with server success");
                    }
                },
                stdGto,
                "SERVER",
                qf
        );

    }


    private Handler regCompleteHandler = new Handler(){
        @Override
        public void handleMessage(Message msg) {
            DBG.write("regCompleteHandler()");
            if(msg.what != 0) {
                // Toast.makeText(QWActivity.this, "Started Golgi Service", Toast.LENGTH_LONG).show();
                registerForAlerts();
            }
            else{
                Toast.makeText(QWActivity.this, "Failed to start Golgi Service", Toast.LENGTH_LONG).show();
            }
        }
    };

    public void golgiRegistrationComplete(boolean success){
        DBG.write("golgiRegistrationComplete: " + success);
        regCompleteHandler.sendEmptyMessage(success ? 1 : 0);
    }



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_qw);
        DBG.write("Hello World");
        stdGto = new GolgiTransportOptions();
        stdGto.setValidityPeriod(60);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.qw, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private static Handler logHandler;

    private void showThreshold(){
        if(inFg){

            if(nfnThresholdTv != null) {
                nfnThresholdTv.setText("Notification Magnitude Threshold: " + getNotificationThreshold(this) + ".0");
            }

            if(nfnSb != null){
                nfnSb.setProgress(getNotificationThreshold(this));
            }
        }
    }

    @Override
    public void onResume(){
        DBG.write("onResume()");
        super.onResume();
        inFg = true;
        GolgiAPI.usePersistentConnection();
        QWService.setQWActivity(this);

        if(!QWService.isRunning(this)){
            DBG.write("Start the service");
            QWService.startService(this.getApplicationContext());
        }
        else {
            DBG.write("Service already started");
        }

        logHandler =  new Handler() {
            public void handleMessage(Message msg) {
                if(inFg) {
                    String log = getQuakeLog().trim();

                    if (log.length() == 0) {
                        log = "NO EARTHQUAKES HAVE BEEN RECORDED";
                    }

                    logTv.setText(log);

                    scrollView.post(new Runnable() {
                        @Override
                        public void run() {
                            scrollView.fullScroll(View.FOCUS_DOWN);
                        }
                    });
                }
            }
        };

        logTv = (TextView)findViewById(R.id.logTv);
        scrollView = (ScrollView)findViewById(R.id.scrollView);
        nfnSb = (SeekBar)findViewById(R.id.nfnSeekBar);
        nfnThresholdTv = (TextView)findViewById(R.id.nfnThresholdTv);
        showThreshold();

        nfnSb.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                DBG.write("SeekBar Stop: " + progress + "(" + fromUser + ")");
                if(fromUser){
                    setNotificationThreshold(QWActivity.this, progress);
                    showThreshold();
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
            }
        });

        logHandler.sendEmptyMessage(0);
    }

    @Override
    public void onPause(){
        DBG.write("onPause()");
        super.onPause();
        inFg = false;
        QWService.setQWActivity(null);
        GolgiAPI.useEphemeralConnection();
        logHandler = null;
    }



}
