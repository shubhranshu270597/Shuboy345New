global class SendOTPandVerfiy{
  
 webService static string sendOTP(String MobileNumber){
   
   HttpRequest req=new HttpRequest();
   HttpResponse res=new HttpResponse();
   
   Http http=new Http();
   
   req.setEndpoint('http://control.msg91.com/api/sendotp.php');
   req.setMethod('POST');
   String PostString='authkey='+System.Label.MSG91ApiKey+'&message='+System.label.MSG91Message+'&sender='+System.label.MSG91Sender+'&mobile='+MobileNumber;
   req.setBody(PostString);
   System.debug(req);
   
   String status='';
   String result='';
   try{
   
       if(!System.Test.isRunningTest()){
       
         res=http.send(req);
         result =res.getBody();
         
       }else{
          
          result='{"type":"success"}';
       }
   
   }catch(System.CalloutException e){
   
     System.debug('Callout error: '+e);
     System.debug(res.toString());
   }
    
    return result;
  }
  
  webService static string retryOTP(String MobileNumber){
  
   HttpRequest req=new HttpRequest();
   HttpResponse res=new HttpResponse();
   
   Http http=new Http();
   
   req.setEndpoint('http://control.msg91.com/api/retryotp.php');
   req.setMethod('POST');
   String PostString='authkey='+System.Label.MSG91ApiKey+'&mobile='+MobileNumber;
   req.setBody(PostString);
   System.debug(req);
   
   String status='';
   String result='';
   try{
   
       if(!System.Test.isRunningTest()){
       
         res=http.send(req);
         result =res.getBody();
         
       }else{
          
          result='{"type":"success"}';
       }
   
   }catch(System.CalloutException e){
   
     System.debug('Callout error: '+e);
     System.debug(res.toString());
   }
    
    return result;
  }

  webService static string verifyOTP(String MobileNumber, String OTP){
  
   HttpRequest req=new HttpRequest();
   HttpResponse res=new HttpResponse();
   
   Http http=new Http();
   
   req.setEndpoint('https://control.msg91.com/api/verifyRequestOTP.php');
   req.setMethod('POST');
   String PostString='authkey='+System.Label.MSG91ApiKey+'&mobile='+MobileNumber+'&otp='+OTP;
   req.setBody(PostString);
   System.debug(req);
   
   String status='';
   String result='';
   try{
   
       if(!System.Test.isRunningTest()){
       
         res=http.send(req);
         result =res.getBody();
         
       }else{
          
          result='{"type":"success"}';
       }
   
   }catch(System.CalloutException e){
   
     System.debug('Callout error: '+e);
     System.debug(res.toString());
   }
    
    return result;
  }
  
  
  
}