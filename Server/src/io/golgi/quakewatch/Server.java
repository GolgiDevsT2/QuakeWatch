//
// This Software (the “Software”) is supplied to you by Openmind Networks
// Limited ("Openmind") your use, installation, modification or
// redistribution of this Software constitutes acceptance of this disclaimer.
// If you do not agree with the terms of this disclaimer, please do not use,
// install, modify or redistribute this Software.
//
// TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED ON AN
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER
// EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR
// CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Each user of the Software is solely responsible for determining the
// appropriateness of using and distributing the Software and assumes all
// risks associated with use of the Software, including but not limited to
// the risks and costs of Software errors, compliance with applicable laws,
// damage to or loss of data, programs or equipment, and unavailability or
// interruption of operations.
//
// TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW OPENMIND SHALL NOT
// HAVE ANY LIABILITY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, WITHOUT LIMITATION,
// LOST PROFITS, LOSS OF BUSINESS, LOSS OF USE, OR LOSS OF DATA), HOWSOEVER 
// CAUSED UNDER ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
// WAY OUT OF THE USE OR DISTRIBUTION OF THE SOFTWARE, EVEN IF ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGES.
//

package io.golgi.quakewatch;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;


import com.json.parsers.JsonParserFactory;
import com.json.parsers.JSONParser;
import com.openmindnetworks.golgi.JavaType;
import com.openmindnetworks.golgi.api.GolgiAPI;
import com.openmindnetworks.golgi.api.GolgiAPIHandler;
import com.openmindnetworks.golgi.api.GolgiAPIImpl;
import com.openmindnetworks.golgi.api.GolgiAPINetworkImpl;
import com.openmindnetworks.golgi.api.GolgiException;
import com.openmindnetworks.golgi.api.GolgiTransportOptions;
import com.openmindnetworks.slingshot.ntl.NTL;
import com.openmindnetworks.slingshot.tbx.TBX;

import io.golgi.quakewatch.gen.*;
import io.golgi.quakewatch.gen.QuakeWatchService.*;


public class Server extends Thread implements GolgiAPIHandler{
    private String devKey = null;
    private String appKey = null;
    private String identity;
    private String paramString;
    private String resultString;
    private boolean persist = false;
    private Hashtable<String,QuakeFilter> userList = new Hashtable<String,QuakeFilter>();
    private Hashtable<String,String> quakeHash = new Hashtable<String,String>();

    private GolgiTransportOptions stdGto;
    private GolgiTransportOptions hourGto;
    private GolgiTransportOptions dayGto;
    
    private class QuakeAlertResultReceiver implements quakeAlert.ResultReceiver{
    	private String target;
        @Override
        public void success() {
            System.out.println("Sending new quakeAlert: success");
        }
        
        @Override
        public void failure(GolgiException ex) {
            // System.out.println("Sending quakeAlert: fail: '" + ex.getErrText() + "'");
            //
            // Remove the User
            //
            synchronized(userList){
            	System.out.println("Removing device '" + target + "' from the user list");
            	userList.remove(target);
            }
            saveUsers();
            
        }
        
        QuakeAlertResultReceiver(String target){
        	this.target = target;
        }
    }

    void sendAlerts(QuakeDetails quakeDetails){
    	Vector<String> v = new Vector<String>();
    	synchronized(userList){
    		for(Enumeration<String> e = userList.keys(); e.hasMoreElements();){
    			v.add(e.nextElement());
    		}
    	}
    	System.out.println("Send Quake Details to " + v.size() + " registered users");
    	while((v.size() > 0)){
    		String user = v.remove(0);
    		System.out.println("Send to '" + user + "'");
    		quakeAlert.sendTo(
    						new QuakeAlertResultReceiver(user),
                            hourGto,
                            user,
                            quakeDetails);
    	}
    }
    
    private void loadUsers(){
    	try{
            BufferedReader br = new BufferedReader(new FileReader("QW-Users.txt"));
            userList = new Hashtable<String,QuakeFilter>();
            QuakeFilter qf;
            
            String id;
            while((id = br.readLine()) != null){
            	qf = new QuakeFilter(true);
            	qf.setGolgiId(id);
                userList.put(id, qf);
            }
            System.out.println("Loaded " + userList.size() + " users");
        }
        catch(IOException iex){
        }
    }
    
    private void saveUsers(){
        try{
            BufferedWriter bw = new BufferedWriter(new FileWriter("QW-Users.txt"));
            Vector<String> v = new Vector<String>();
            synchronized(userList){
                for(Enumeration<String> e = userList.keys(); e.hasMoreElements();){
                    v.add(e.nextElement());
                }
            }
            while((v.size() > 0)){
                String user = v.remove(0);
                bw.write(user  + "\n");
            }
            bw.close();
        }
        catch(IOException ioex){
        }
        
    }
    private void loadQuakeData(){
    	try{
            BufferedReader br = new BufferedReader(new FileReader("QW-Data.txt"));
            quakeHash = new Hashtable<String,String>();
                        
            String id;
            while((id = br.readLine()) != null){
            	quakeHash.put(id, "");
            }
            System.out.println("Loaded " + quakeHash.size() + " quakes");
        }
        catch(IOException iex){
        }
    }
    private void saveQuakeData(){
        try{
            BufferedWriter bw = new BufferedWriter(new FileWriter("QW-Data.txt"));
            Vector<String> v = new Vector<String>();
            synchronized(quakeHash){
                for(Enumeration<String> e = quakeHash.keys(); e.hasMoreElements();){
                    v.add(e.nextElement());
                }
            }
            while((v.size() > 0)){
                String user = v.remove(0);
                bw.write(user  + "\n");
            }
            bw.close();
        }
        catch(IOException ioex){
        }
    }
    
    
    private addMe.RequestReceiver inboundAddMe = new addMe.RequestReceiver(){
        public void receiveFrom(addMe.ResultSender resultSender, QuakeFilter quakeFilter){
            System.out.println("Asked to add: " + quakeFilter.getGolgiId());
            synchronized(userList){
                if(!userList.containsKey(quakeFilter.getGolgiId())){
                    userList.put(quakeFilter.getGolgiId(), quakeFilter);
                    System.out.println("We now know about " + userList.size() + " users");
                    saveUsers();
                }
            }
            resultSender.success();
        }
    };

    

    @Override
    public void registerSuccess() {
        System.out.println("Registered successfully with Golgi API");
    }


    @Override
    public void registerFailure() {
        System.err.println("Failed to register with Golgi API");
        System.exit(-1);
    }

    static void abort(String err) {
        System.err.println("Error: " + err);
        System.exit(-1);
    }


    private int hkTmp = -1;
    
    String getFeed(String url){
        String result = null;
        HttpClient httpclient = new DefaultHttpClient();
        HttpGet httpget = new HttpGet(url);
        HttpResponse response;
        try{
                response = httpclient.execute(httpget);
                                        
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                        InputStream iStream = entity.getContent();
                        StringWriter writer = new StringWriter();
                        IOUtils.copy(iStream, writer, "UTF-8");
                        result = writer.toString();                             
                }
                else{
                        System.out.println("Failed to read feed from: '" + url + "'");
                }
        }
        catch(ClientProtocolException cpe){
                
        }
        catch(NoSuchElementException nse){
            
        }
        catch(IOException ioe){
                
        }
        return result;
}
    
    private boolean first = true;
    private void houseKeep(){
    	System.out.println("Tick");
    	String data = getFeed("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson");
    	
    	JsonParserFactory factory=JsonParserFactory.getInstance();
    	
    	 JSONParser parser= factory.newJsonParser();
    	 
    	 Map jsonData = null;
    	 
    	 try{
    		   jsonData = parser.parseJson(data);
    	 }
    	 catch(IllegalArgumentException iae){
    		 jsonData = null;
    	 }
    	 catch(Exception e){
    		 System.out.println("Parsing exploded: " + e.toString());
    		 jsonData = null;
    	 }
    	 
    	 if(jsonData != null){
    		 String str = (String)jsonData.get("type");
    	 
    		 System.out.println("Type: " + str);
    	 
    		 List<Map> al = (List<Map>)jsonData.get("features");
    	 
    		 System.out.println("The list has: " + al.size());
    		 int now = (int)(System.currentTimeMillis() / 1000); 
    		 for(Iterator<Map> it = al.iterator(); it.hasNext();){
    			 double lat = 0.0;
    			 double lng = 0.0;
    			 double depth = 0.0;
    			 double mag = 0.0;
    			 long t = 0;
    			 int timestamp = 0;
    			 boolean ignore = false;
    		 
    			 Map quake = it.next();
    			 Map properties = (Map)quake.get("properties");
    			 Map geometry  = (Map)quake.get("geometry");
    		 
    			 if(((String)geometry.get("type")).compareToIgnoreCase("Point") != 0){
    				 ignore = true;
    			 }
    			 else{
    				 List<String> pList = (List<String>)geometry.get("coordinates");
    				 if(pList == null || pList.size() != 3){
    					 ignore = true;
    				 }
    				 else{
    					 try{
    						 lng = Double.valueOf(pList.get(0));
    						 lat = Double.valueOf(pList.get(1));
    						 depth = Double.valueOf(pList.get(2));
    						 mag = Double.valueOf((String)properties.get("mag"));
    					 }
    					 catch(NumberFormatException nfe){
    						 ignore = true;
    					 }
    				 }
    			 }

    			 try{
    				 t = Long.valueOf((String)properties.get("time"));
    			 }
    			 catch(NumberFormatException nfe){
    				 ignore = true;
    			 }
    		 
    			 String type, title;
    			 title = (String)properties.get("title");
    			 type = (String)properties.get("type");
    		 
    			 if(!ignore && type.compareToIgnoreCase("earthquake") == 0 && !quakeHash.containsKey("" + t)){
    				 quakeHash.put("" + t, "");
    				 saveQuakeData();
    				 timestamp = (int)(t / 1000);
    				 t /= 1000;
    				 System.out.println(" Magnitude: " + properties.get("mag") + " " + (now - t) + " " + lat + "/" + lng + "/" + depth + ": '" + title + "'");
    				 QuakeDetails qd = new QuakeDetails(true);
    				 qd.setLat(lat);
    				 qd.setLng(lng);
    				 qd.setMag(mag);
    				 qd.setTimestamp(timestamp);
    				 qd.setTitle(title);
    				 if(!first){
    					 sendAlerts(qd);
    				 }
    			 }
    		 }
    		 first = false;
    	 }

    }
    
    private void looper(){
        Class<GolgiAPI> apiRef = GolgiAPI.class;
        GolgiAPINetworkImpl impl = new GolgiAPINetworkImpl();
        GolgiAPI.setAPIImpl(impl);
        stdGto = new GolgiTransportOptions();
        stdGto.setValidityPeriod(60);

        hourGto = new GolgiTransportOptions();
        hourGto.setValidityPeriod(3600);

        dayGto = new GolgiTransportOptions();
        dayGto.setValidityPeriod(86400);

        loadUsers();
        loadQuakeData();
        
        addMe.registerReceiver(inboundAddMe);

        // WhozinService.registerDevice.registerReceiver(registerDeviceSS);
        GolgiAPI.register(devKey,
                          appKey,
                          "SERVER",
                          this);
        
        Timer hkTimer;
        hkTimer = new Timer();
        hkTimer.schedule(new TimerTask(){
            @Override
            public void run() {
                houseKeep();
            }
        }, 10000, 45000);
        
    }
    
    private Server(String[] args){
        for(int i = 0; i < args.length; i++){
        	if(args[i].compareTo("-devKey") == 0){
        		devKey = args[i+1];
        		i++;
        	}
        	else if(args[i].compareTo("-appKey") == 0){
        		appKey = args[i+1];
        		i++;
        	}
        	else{
        		System.err.println("Zoikes, unrecognised option '" + args[i] + "'");
        		System.exit(-1);;
        	}
        }
        if(devKey == null){
        	System.out.println("No -devKey specified");
        	System.exit(-1);
        }
        else if(appKey == null){
        	System.out.println("No -appKey specified");
        	System.exit(-1);
        }
    }
        
    public static void main(String[] args) {
        (new Server(args)).looper();
    }
}
