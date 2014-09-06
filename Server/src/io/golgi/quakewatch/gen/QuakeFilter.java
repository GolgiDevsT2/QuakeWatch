/* IS_AUTOGENERATED_SO_ALLOW_AUTODELETE=YES */
/* The previous line is to allow auto deletion */

package io.golgi.quakewatch.gen;

import java.util.Hashtable;
import java.util.ArrayList;
import java.util.Iterator;
import com.openmindnetworks.golgi.JavaType;
import com.openmindnetworks.golgi.GolgiPayload;
import com.openmindnetworks.golgi.B64;
import com.openmindnetworks.golgi.api.GolgiException;
import com.openmindnetworks.golgi.api.GolgiAPI;

public class QuakeFilter
{

    private boolean corrupt = false;

    public boolean isCorrupt() {
        return corrupt;
    }

    public void setCorrupt() {
        corrupt = true;
    }

    private boolean golgiIdIsSet = false;
    private String golgiId;
    private boolean latIsSet = false;
    private double lat;
    private boolean lngIsSet = false;
    private double lng;
    private boolean radiusIsSet = false;
    private double radius;

    public String getGolgiId(){
        return golgiId;
    }
    public boolean golgiIdIsSet(){
        return golgiIdIsSet;
    }
    public void setGolgiId(String golgiId){
        this.golgiId = golgiId;
        this.golgiIdIsSet = true;
    }

    public double getLat(){
        return lat;
    }
    public boolean latIsSet(){
        return latIsSet;
    }
    public void setLat(double lat){
        this.lat = lat;
        this.latIsSet = true;
    }

    public double getLng(){
        return lng;
    }
    public boolean lngIsSet(){
        return lngIsSet;
    }
    public void setLng(double lng){
        this.lng = lng;
        this.lngIsSet = true;
    }

    public double getRadius(){
        return radius;
    }
    public boolean radiusIsSet(){
        return radiusIsSet;
    }
    public void setRadius(double radius){
        this.radius = radius;
        this.radiusIsSet = true;
    }

    public StringBuffer serialise(){
        return serialise(null);
    }

    public StringBuffer serialise(StringBuffer sb){
        return serialise("", sb);
    }

    public StringBuffer serialise(String prefix, StringBuffer sb){
        if(sb == null){
            sb = new StringBuffer();
        }

        if(this.golgiIdIsSet){
            sb.append(prefix + "1: " + JavaType.encodeString(this.golgiId) + "\n");
        }
        if(this.latIsSet){
            sb.append(prefix + "2: " + GolgiAPI.doubleToString(this.lat)+"\n");
        }
        if(this.lngIsSet){
            sb.append(prefix + "3: " + GolgiAPI.doubleToString(this.lng)+"\n");
        }
        if(this.radiusIsSet){
            sb.append(prefix + "4: " + GolgiAPI.doubleToString(this.radius)+"\n");
        }

        return sb;
    }

    private void deserialise(GolgiPayload payload){
        if(!isCorrupt() && payload.containsFieldKey("1:")){
            String val = payload.getField("1:");
            String str = JavaType.decodeString(val);
            if(str != null){
                setGolgiId(str);
            }
            else{
                setCorrupt();
            }
        }
        else{
            setCorrupt();
        }
        if(!isCorrupt() && payload.containsFieldKey("2:")){
            String str = payload.getField("2:");
            setLat(GolgiAPI.stringToDouble(str));
        }
        else{
            setCorrupt();
        }
        if(!isCorrupt() && payload.containsFieldKey("3:")){
            String str = payload.getField("3:");
            setLng(GolgiAPI.stringToDouble(str));
        }
        else{
            setCorrupt();
        }
        if(!isCorrupt() && payload.containsFieldKey("4:")){
            String str = payload.getField("4:");
            setRadius(GolgiAPI.stringToDouble(str));
        }
        else{
            setCorrupt();
        }
    }

    public QuakeFilter(){
        this(true);
    }

    public QuakeFilter(boolean isSetDefault){
        super();
        golgiIdIsSet = isSetDefault;
        golgiId = new String();
        latIsSet = isSetDefault;
        lat = 0;
        lngIsSet = isSetDefault;
        lng = 0;
        radiusIsSet = isSetDefault;
        radius = 0;
    }

    public QuakeFilter(GolgiPayload payload){
        this(false);
        deserialise(payload);
    }

    public QuakeFilter(String payload){
        this(JavaType.createPayload(payload));
    }

}