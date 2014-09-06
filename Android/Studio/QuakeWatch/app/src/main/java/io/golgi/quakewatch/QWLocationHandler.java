package io.golgi.quakewatch;

import android.content.Context;
import android.location.Location;
import android.os.Bundle;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesClient;
import com.google.android.gms.location.LocationClient;

/**
 * Created by brian on 8/28/14.
 */
public class QWLocationHandler implements
        GooglePlayServicesClient.ConnectionCallbacks,
        GooglePlayServicesClient.OnConnectionFailedListener {

    public interface LocationListener{
        public void locationSetupError(String txt);
        public void locationSetupOk();

        public void locationReady(double lat, double lng);
        public void locationError(String txt);
    }

    private LocationClient mLocationClient;
    private Context context;
    private LocationListener lsnr;
    private Location mCurrentLocation;

    @Override
    public void onConnected(Bundle bundle) {
        DBG.write("Location Handler connected");

        mCurrentLocation = mLocationClient.getLastLocation();
        DBG.write("CurrentLoation: " + mCurrentLocation.toString());

        lsnr.locationReady(mCurrentLocation.getLatitude(), mCurrentLocation.getLongitude());

        mLocationClient.disconnect();
    }

    @Override
    public void onDisconnected() {
        DBG.write("Location Handler disconnected");
        lsnr = null;
    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {
        DBG.write("Location Handler connectionFailed: " + connectionResult.toString());
        lsnr.locationSetupError("Problems connection to location service");
    }

    private void stop(){
        mLocationClient.disconnect();
        mLocationClient = null;
    }


    QWLocationHandler(Context context, LocationListener lsnr){
        this.context = context;
        this.lsnr = lsnr;
        mLocationClient = new LocationClient(context, this, this);
        mLocationClient.connect();

    }
}
