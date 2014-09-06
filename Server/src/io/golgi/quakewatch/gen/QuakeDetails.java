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

public class QuakeDetails
{

    private boolean corrupt = false;

    public boolean isCorrupt() {
        return corrupt;
    }

    public void setCorrupt() {
        corrupt = true;
    }

    private boolean magIsSet = false;
    private double mag;
    private boolean latIsSet = false;
    private double lat;
    private boolean lngIsSet = false;
    private double lng;
    private boolean titleIsSet = false;
    private String title;
    private boolean timestampIsSet = false;
    private int timestamp;

    public double getMag(){
        return mag;
    }
    public boolean magIsSet(){
        return magIsSet;
    }
    public void setMag(double mag){
        this.mag = mag;
        this.magIsSet = true;
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

    public String getTitle(){
        return title;
    }
    public boolean titleIsSet(){
        return titleIsSet;
    }
    public void setTitle(String title){
        this.title = title;
        this.titleIsSet = true;
    }

    public int getTimestamp(){
        return timestamp;
    }
    public boolean timestampIsSet(){
        return timestampIsSet;
    }
    public void setTimestamp(int timestamp){
        this.timestamp = timestamp;
        this.timestampIsSet = true;
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

        if(this.magIsSet){
            sb.append(prefix + "1: " + GolgiAPI.doubleToString(this.mag)+"\n");
        }
        if(this.latIsSet){
            sb.append(prefix + "2: " + GolgiAPI.doubleToString(this.lat)+"\n");
        }
        if(this.lngIsSet){
            sb.append(prefix + "3: " + GolgiAPI.doubleToString(this.lng)+"\n");
        }
        if(this.titleIsSet){
            sb.append(prefix + "4: " + JavaType.encodeString(this.title) + "\n");
        }
        if(this.timestampIsSet){
            sb.append(prefix + "5: " + this.timestamp+"\n");
        }

        return sb;
    }

    private void deserialise(GolgiPayload payload){
        if(!isCorrupt() && payload.containsFieldKey("1:")){
            String str = payload.getField("1:");
            setMag(GolgiAPI.stringToDouble(str));
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
            String val = payload.getField("4:");
            String str = JavaType.decodeString(val);
            if(str != null){
                setTitle(str);
            }
            else{
                setCorrupt();
            }
        }
        else{
            setCorrupt();
        }
        if(!isCorrupt() && payload.containsFieldKey("5:")){
            String str = payload.getField("5:");
            try{
                setTimestamp(Integer.valueOf(str));
            }
            catch(NumberFormatException nfe){
                setCorrupt();
            }
        }
        else{
            setCorrupt();
        }
    }

    public QuakeDetails(){
        this(true);
    }

    public QuakeDetails(boolean isSetDefault){
        super();
        magIsSet = isSetDefault;
        mag = 0;
        latIsSet = isSetDefault;
        lat = 0;
        lngIsSet = isSetDefault;
        lng = 0;
        titleIsSet = isSetDefault;
        title = new String();
        timestampIsSet = isSetDefault;
        timestamp = 0;
    }

    public QuakeDetails(GolgiPayload payload){
        this(false);
        deserialise(payload);
    }

    public QuakeDetails(String payload){
        this(JavaType.createPayload(payload));
    }

}