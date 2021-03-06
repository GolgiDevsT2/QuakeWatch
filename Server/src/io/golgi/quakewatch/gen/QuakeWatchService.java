/* IS_AUTOGENERATED_SO_ALLOW_AUTODELETE=YES */
/* The previous line is to allow auto deletion */

package io.golgi.quakewatch.gen;

import java.util.Hashtable;
import java.util.ArrayList;
import java.util.Iterator;
import com.openmindnetworks.golgi.JavaType;
import com.openmindnetworks.golgi.GolgiPayload;
import com.openmindnetworks.golgi.B64;
import com.openmindnetworks.golgi.api.*;

public interface QuakeWatchService{
    public static class addMe{
        public interface ResultSender{
            public void success();
        }

        public interface ResultReceiver extends ResultSender{
            public void failure(GolgiException ex);
        }

        public static class InboundResponseHandler implements GolgiAPIIBResponseHandler{
            private ResultReceiver resultReceiver;
            @Override
            public void error(int errType, String errText){
                GolgiException ex = new GolgiException();
                ex.setErrType(errType);
                ex.setErrText(errText);
                resultReceiver.failure(ex);
            }
            @Override
            public void remoteResponse(String payload){
                QuakeWatch_addMe_rspArg rsp;
                rsp = new QuakeWatch_addMe_rspArg(payload);
                if(rsp == null || rsp.isCorrupt()){
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(1)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
                if(rsp.getInternalSuccess_() != 0){
                    resultReceiver.success();
                }
                else{
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(2)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
            }
            public InboundResponseHandler(ResultReceiver resultReceiver){
                this.resultReceiver = resultReceiver;
            }
        }

        public static void sendTo(ResultReceiver receiver, GolgiTransportOptions cto, String destination, QuakeFilter filter){
            QuakeWatch_addMe_reqArg arg = new QuakeWatch_addMe_reqArg();

            arg.setFilter(filter);

            StringBuffer sb = arg.serialise();
            GolgiAPI.getInstance().sendRequest(new InboundResponseHandler(receiver), cto, destination, "addMe.QuakeWatch", sb.toString());
        }

        public static void sendTo(ResultReceiver receiver, String destination, QuakeFilter filter){
            sendTo(receiver, null, destination, filter);
        }

        public interface RequestReceiver{
            public void receiveFrom(ResultSender resultSender, QuakeFilter filter);
        }

        public static class InboundRequestReceiver implements GolgiAPIRequestReceiver,ResultSender{
            private RequestReceiver requestReceiver;
            private GolgiAPIOBResponseHandler obResponseSender;

            @Override
            public void incomingRequest(GolgiAPIOBResponseHandler handler, String payload){
                this.obResponseSender = handler;

                QuakeWatch_addMe_reqArg arg = new QuakeWatch_addMe_reqArg(payload);
                if(arg.isCorrupt()){
                    handler.remotePayloadError();
                    return;
                }
                requestReceiver.receiveFrom(this, arg.getFilter());
            }

            @Override
            public void success(){
                QuakeWatch_addMe_rspArg rspArg = new QuakeWatch_addMe_rspArg(false);
                rspArg.setInternalSuccess_(1);
                obResponseSender.send(rspArg.serialise().toString());
            }

            public InboundRequestReceiver(RequestReceiver requestReceiver){
                this.requestReceiver = requestReceiver;
            }
        }

        public static void registerReceiver(RequestReceiver requestReceiver){
           GolgiAPI.getInstance().registerReqReceiver(new InboundRequestReceiver(requestReceiver), "addMe.QuakeWatch");
        }

    }
    public static class removeMe{
        public interface ResultSender{
            public void success();
        }

        public interface ResultReceiver extends ResultSender{
            public void failure(GolgiException ex);
        }

        public static class InboundResponseHandler implements GolgiAPIIBResponseHandler{
            private ResultReceiver resultReceiver;
            @Override
            public void error(int errType, String errText){
                GolgiException ex = new GolgiException();
                ex.setErrType(errType);
                ex.setErrText(errText);
                resultReceiver.failure(ex);
            }
            @Override
            public void remoteResponse(String payload){
                QuakeWatch_removeMe_rspArg rsp;
                rsp = new QuakeWatch_removeMe_rspArg(payload);
                if(rsp == null || rsp.isCorrupt()){
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(1)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
                if(rsp.getInternalSuccess_() != 0){
                    resultReceiver.success();
                }
                else{
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(2)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
            }
            public InboundResponseHandler(ResultReceiver resultReceiver){
                this.resultReceiver = resultReceiver;
            }
        }

        public static void sendTo(ResultReceiver receiver, GolgiTransportOptions cto, String destination, String golgiId){
            QuakeWatch_removeMe_reqArg arg = new QuakeWatch_removeMe_reqArg();

            arg.setGolgiId(golgiId);

            StringBuffer sb = arg.serialise();
            GolgiAPI.getInstance().sendRequest(new InboundResponseHandler(receiver), cto, destination, "removeMe.QuakeWatch", sb.toString());
        }

        public static void sendTo(ResultReceiver receiver, String destination, String golgiId){
            sendTo(receiver, null, destination, golgiId);
        }

        public interface RequestReceiver{
            public void receiveFrom(ResultSender resultSender, String golgiId);
        }

        public static class InboundRequestReceiver implements GolgiAPIRequestReceiver,ResultSender{
            private RequestReceiver requestReceiver;
            private GolgiAPIOBResponseHandler obResponseSender;

            @Override
            public void incomingRequest(GolgiAPIOBResponseHandler handler, String payload){
                this.obResponseSender = handler;

                QuakeWatch_removeMe_reqArg arg = new QuakeWatch_removeMe_reqArg(payload);
                if(arg.isCorrupt()){
                    handler.remotePayloadError();
                    return;
                }
                requestReceiver.receiveFrom(this, arg.getGolgiId());
            }

            @Override
            public void success(){
                QuakeWatch_removeMe_rspArg rspArg = new QuakeWatch_removeMe_rspArg(false);
                rspArg.setInternalSuccess_(1);
                obResponseSender.send(rspArg.serialise().toString());
            }

            public InboundRequestReceiver(RequestReceiver requestReceiver){
                this.requestReceiver = requestReceiver;
            }
        }

        public static void registerReceiver(RequestReceiver requestReceiver){
           GolgiAPI.getInstance().registerReqReceiver(new InboundRequestReceiver(requestReceiver), "removeMe.QuakeWatch");
        }

    }
    public static class quakeAlert{
        public interface ResultSender{
            public void success();
        }

        public interface ResultReceiver extends ResultSender{
            public void failure(GolgiException ex);
        }

        public static class InboundResponseHandler implements GolgiAPIIBResponseHandler{
            private ResultReceiver resultReceiver;
            @Override
            public void error(int errType, String errText){
                GolgiException ex = new GolgiException();
                ex.setErrType(errType);
                ex.setErrText(errText);
                resultReceiver.failure(ex);
            }
            @Override
            public void remoteResponse(String payload){
                QuakeWatch_quakeAlert_rspArg rsp;
                rsp = new QuakeWatch_quakeAlert_rspArg(payload);
                if(rsp == null || rsp.isCorrupt()){
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(1)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
                if(rsp.getInternalSuccess_() != 0){
                    resultReceiver.success();
                }
                else{
                    GolgiException ex = new GolgiException();
                    ex.setErrText("corrupt response(2)");
                    ex.setErrType(golgi_message.ERRTYPE_PAYLOAD_MISMATCH);
                    resultReceiver.failure(ex);
                }
            }
            public InboundResponseHandler(ResultReceiver resultReceiver){
                this.resultReceiver = resultReceiver;
            }
        }

        public static void sendTo(ResultReceiver receiver, GolgiTransportOptions cto, String destination, QuakeDetails details){
            QuakeWatch_quakeAlert_reqArg arg = new QuakeWatch_quakeAlert_reqArg();

            arg.setDetails(details);

            StringBuffer sb = arg.serialise();
            GolgiAPI.getInstance().sendRequest(new InboundResponseHandler(receiver), cto, destination, "quakeAlert.QuakeWatch", sb.toString());
        }

        public static void sendTo(ResultReceiver receiver, String destination, QuakeDetails details){
            sendTo(receiver, null, destination, details);
        }

        public interface RequestReceiver{
            public void receiveFrom(ResultSender resultSender, QuakeDetails details);
        }

        public static class InboundRequestReceiver implements GolgiAPIRequestReceiver,ResultSender{
            private RequestReceiver requestReceiver;
            private GolgiAPIOBResponseHandler obResponseSender;

            @Override
            public void incomingRequest(GolgiAPIOBResponseHandler handler, String payload){
                this.obResponseSender = handler;

                QuakeWatch_quakeAlert_reqArg arg = new QuakeWatch_quakeAlert_reqArg(payload);
                if(arg.isCorrupt()){
                    handler.remotePayloadError();
                    return;
                }
                requestReceiver.receiveFrom(this, arg.getDetails());
            }

            @Override
            public void success(){
                QuakeWatch_quakeAlert_rspArg rspArg = new QuakeWatch_quakeAlert_rspArg(false);
                rspArg.setInternalSuccess_(1);
                obResponseSender.send(rspArg.serialise().toString());
            }

            public InboundRequestReceiver(RequestReceiver requestReceiver){
                this.requestReceiver = requestReceiver;
            }
        }

        public static void registerReceiver(RequestReceiver requestReceiver){
           GolgiAPI.getInstance().registerReqReceiver(new InboundRequestReceiver(requestReceiver), "quakeAlert.QuakeWatch");
        }

    }
}
