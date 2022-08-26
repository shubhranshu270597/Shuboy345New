@isTest
public class OTPBased_LoginControllerTracker{

    private class SendOTPRestMock implements HttpCalloutMock{
  
        SendOTPRestMock(){}
      
      public HTTPResponse respond(HTTPRequest req) {
        
        String fullJson =  '{"message":"386b79747a4b393638313531","type":"success"}';
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(fullJson);
        res.setStatusCode(200);
        return res;
     }
  }

   private class OTPVerifyMock implements HttpCalloutMock{
      
       OTPVerifyMock(){}
      
      public HTTPResponse respond(HTTPRequest req) {
        
        String fullJson =  '{"message":"otp_verified","type":"success"}';
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(fullJson);
        res.setStatusCode(200);
        return res;
     }
  }
  
   private class RetryOTPMock implements HttpCalloutMock{
      
       RetryOTPMock(){}
      
      public HTTPResponse respond(HTTPRequest req) {
        
        String fullJson =  '{"message":"otp_sent_successfully","type":"success"}';
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(fullJson);
        res.setStatusCode(200);
        return res;
     }
  } 
  
    private class CalloutExceptionRestMock implements HttpCalloutMock {
        CalloutExceptionRestMock() {  
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            throw new System.CalloutException();
        }
    }
  
      public static Lead createLead(){
     
        Lead objLead = new Lead();
        objLead.LastName = 'ttforotp';
        objLead.FirstName = 'ttforservice';
        objLead.Email='tt@gmail.com';
        objLead.Password__c='test1';
        objLead.Company = 'Test1 Co. Pvt. Ltd.';
        objLead.MobilePhone='8888888888';
        Insert objLead;
        return objLead;
     }
     
     public static testMethod void TestForSendOTP(){
       
        OTPBasedLoginPageNewController otpbaselogin = new OTPBasedLoginPageNewController();
        otpbaselogin.objLead= createLead();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendOTPRestMock());
        otpbaselogin.LoginToMyPage();   
        Test.stopTest();
        
    }
  
     public static testMethod void TestForRetryOTP(){
        
        OTPBasedLoginPageNewController otpbaselogin = new OTPBasedLoginPageNewController();
        otpbaselogin.objLead= createLead();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new RetryOTPMock());
        otpbaselogin.objLeadId=otpbaselogin.objLead.Id;
        otpbaselogin.OTP=null;
        otpbaselogin.retryOTP();
        
        Test.stopTest();
        
    }
    
     public static testMethod void TestForVerifyOTP(){
        
        OTPBasedLoginPageNewController otpbaselogin = new OTPBasedLoginPageNewController();
        otpbaselogin.objLead= createLead();
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new OTPVerifyMock());
        otpbaselogin.objLeadId=otpbaselogin.objLead.Id;
        otpbaselogin.OTP='4512';
        otpbaselogin.LoginAuth();
        Test.stopTest();
        
    }
}