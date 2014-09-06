package io.golgi.quakewatch;

/**
 * Created by brian on 8/28/14.
 */
public class LocHelper {
    public static double calcDistance(double lat1, double lng1, double lat2, double lng2)
    {
        double r = 6371; // km
        double dLat = Math.toRadians(lat2-lat1);
        double dLng = Math.toRadians(lng2-lng1);
        lat1 = Math.toRadians(lat1);
        lat2 = Math.toRadians(lat2);

        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.sin(dLng/2) * Math.sin(dLng/2) * Math.cos(lat1) * Math.cos(lat2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        double d = r * c;

        return (Math.floor(d * 10.0)) / 10.0;
    }


    public static double getBearing(double lat1, double lng1, double lat2, double lng2)
    {
        double dLat = Math.toRadians(lat2-lat1);

        double dLng = Math.toRadians(lng2-lng1);

        lat1 = Math.toRadians(lat1);
        lat2 = Math.toRadians(lat2);

        lng1 = Math.toRadians(lng1);
        lng2 = Math.toRadians(lng2);


        double y = Math.sin(dLng) * Math.cos(lat2);
        double x = Math.cos(lat1)*Math.sin(lat2) -
                Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLng);
        double brng = Math.toDegrees(Math.atan2(y, x));

        return brng;
    }

    private static String bearingWords[] = new String[]{
            "North", "Northeast", "East", "Southeast", "South", "Southwest", "West", "Northwest", "North"
    };

    public static String getBearingAsString(double lat1, double lng1, double lat2, double lng2){
        double b = getBearing(lat1, lng1, lat2, lng2);
        double b1 = b += 22.5;

        if(b1 < 0){
            b1 += 360.0;
        }

        if(b1 >= 360.0){
            b1 -= 360.0;
        }

        int idx = (int)b1 / 45;

        DBG.write("Bearing " + lat1 + ":" + lng1 + " --> " + lat2 + ":" + lng2 + " [" + b + "] is " + bearingWords[idx]);

        return bearingWords[idx];
    }

}
