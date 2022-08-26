/**
 * @File Name          : SendSMSWebService.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 12/4/2019, 7:29:37 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/4/2019   shubhranshu     Initial Version
**/
public without sharing class SendSMSWebService {
   
   public static String sendOtp(String MobileNumber){

        String result = '';
        HttpRequest req=new HttpRequest();
        HttpResponse res=new HttpResponse();
        Http http=new Http();
        
        req.setEndpoint('http://control.msg91.com/api/sendotp.php');
        req.setMethod('POST');
        String PostString='authkey='+System.Label.MSG91ApiKey+'&message='+System.label.MSG91Message+'&sender='+System.label.MSG91Sender+'&mobile='+MobileNumber;
        System.debug('PostString '+PostString);
        req.setBody(PostString);
        System.debug(req);
        res=http.send(req);
        result =res.getBody();
        return result;
    }

    public static String verifyOtp(String MobileNumber,String OTP){

        String result = '';
        HttpRequest req=new HttpRequest();
        HttpResponse res=new HttpResponse();
        Http http=new Http();
        
        req.setEndpoint('https://control.msg91.com/api/verifyRequestOTP.php');
        req.setMethod('POST');
        String PostString='authkey='+System.Label.MSG91ApiKey+'&mobile='+MobileNumber+'&otp='+OTP;
        req.setBody(PostString);
        System.debug(req);
        res=http.send(req);
        result =res.getBody();
        return result;
    }

    public static String retryOtp(String MobileNumber){

        String result = '';
        HttpRequest req=new HttpRequest();
        HttpResponse res=new HttpResponse();
        Http http=new Http();
        
        req.setEndpoint('http://control.msg91.com/api/retryotp.php');
        req.setTimeout(60000);
        req.setMethod('POST');
        String PostString='authkey='+System.Label.MSG91ApiKey+'&mobile='+MobileNumber;
        req.setBody(PostString);
        System.debug(req);
        res=http.send(req);
        result =res.getBody();
        return result;
    }
}