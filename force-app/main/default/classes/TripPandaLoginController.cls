/**
 * @File Name          : TripPandaLoginController.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 9/3/2020, 1:55:46 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    5/12/2019   shubhranshu     Initial Version
**/
public with sharing class TripPandaLoginController {

    public TripPandaUser__c tpUser {get;set;}
    public List<TripPandaUser__c> tpUserList {get;set;}
    public String otp {get;set;}
    public String Mobile {get;set;}
    public String tpuserId {get;set;}
    public String result {get;set;}

    public TripPandaLoginController() {
        tpUser = new TripPandaUser__c();
        tpUserList = new List<TripPandaUser__c>();
        otp = '';
        Mobile = '';
        result = '';
        tpuserId = ApexPages.currentPage().getParameters().get('id');
        // if(String.isBlank(otp)){
        //    retryOTP();
        // }
    }

    public Pagereference LoginAndAuthenticate(){

        if(String.isNotBlank(tpUser.UserName__c) && String.isNotBlank(tpUser.Password__c)){
            tpUserList = [select Id , UserName__c , Password__c , MobileNumber__c from TripPandaUser__c where UserName__c=:tpUser.UserName__c and Password__c=:tpUser.Password__c limit 1 ];

            if(tpUserList.size() > 0){

                tpUser = tpUserList[0];
                Mobile = tpUser.MobileNumber__c;
                if(String.isNotBlank(Mobile)){
                    result = SendSMSWebService.sendOtp(Mobile);
                }
                Map<String,Object> mapOfResponseParameters = (Map<String,Object>)Json.deserializeuntyped(result);
                
                System.debug('mapOfResponseParameters -->'+mapOfResponseParameters);
                
                if(!mapOfResponseParameters.isEmpty()){
                
                        if(mapOfResponseParameters.containsKey('type')){
                        
                            String currentStatus = String.valueOf(mapOfResponseParameters.get('type'));
                            String message = String.valueOf(mapOfResponseParameters.get('message'));
                            
                            System.debug('currentStatus -->'+currentStatus+' '+'message -->'+message);
                            if(currentStatus =='success'){
                                pageReference pg=new pageReference('/apex/TripPandaAuthPAge?id='+tpUser.Id);
                                pg.setRedirect(true); 
                                return pg;  
                            }
                        }
                }
            }else{
                    apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Invalid Credentional..');
                    apexpages.addmessage(msg);
                }
        }else{
            apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please Enter Email Id and Passowrd..');
            apexpages.addmessage(msg);
        }
        return null;
    }

    public pageReference LoginAuth(){
        if(!String.IsBlank(otp)){
         List<TripPandaUser__c> authLst=[select Id,MobileNumber__c from TripPandaUser__c where Id=:tpuserId];
           if(authLst.size() > 0){
                tpUser=authLst[0];
                Mobile =tpUser.MobileNumber__c;
                System.debug('Mobile in Verify OTP Method'+Mobile+' otp-->'+otp+' tpuserId-->'+tpuserId);
                
                if(String.isNotBlank(Mobile) && String.isNotBlank(otp)){
                result = SendSMSWebService.verifyOtp(Mobile,OTP);
                }
                Map<String,Object> mapOfResponseParameters = (Map<String,Object>)Json.deserializeuntyped(result);
                System.debug('mapOfResponseParameters -->'+mapOfResponseParameters);
                if(!mapOfResponseParameters.isEmpty()){
                
                    if(mapOfResponseParameters.containsKey('type')){
                    
                        String currentStatus = String.valueOf(mapOfResponseParameters.get('type'));
                        String message = String.valueOf(mapOfResponseParameters.get('message'));
                        
                        System.debug('currentStatus -->'+currentStatus+' '+'message -->'+message);
                        if(currentStatus =='success'){
                            pageReference pg=new pageReference('/apex/TripPandaForPratiTiruPatiDarshan?id='+tpuserId);
                            pg.setRedirect(true); 
                            return pg;  
                        }
                    }
                }
            }else{
                    apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Invalid OTP..');
                    apexpages.addmessage(msg);
                    }
        }else{
            apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please Enter OTP..');
            apexpages.addmessage(msg);
        }
        return null;
    }

    public pageReference retryOTP(){
      
        System.debug('enter in Retry otp..');
        List<TripPandaUser__c> retryLst=[select Id,MobileNumber__c from TripPandaUser__c where Id=:tpuserId];
        
           if(retryLst.size() > 0){
            
                tpUser=retryLst[0];
                Mobile =tpUser.MobileNumber__c;
                System.debug('Mobile in Retry OTP Method'+Mobile+' tpuserId-->'+tpuserId);
                if(String.isNotBlank(Mobile)){
                    result = SendSMSWebService.retryOtp(Mobile);
                }  
                Map<String,Object> mapOfResponseParameters = (Map<String,Object>)Json.deserializeuntyped(result);
                System.debug('mapOfResponseParameters -->'+mapOfResponseParameters);
                if(!mapOfResponseParameters.isEmpty()){
                    if(mapOfResponseParameters.containsKey('type')){
                        String currentStatus = String.valueOf(mapOfResponseParameters.get('type'));
                        String message = String.valueOf(mapOfResponseParameters.get('message'));
                        
                        System.debug('currentStatus -->'+currentStatus+' '+'message -->'+message);
                        if(currentStatus =='success'){
                            apexpages.Message msg = new Apexpages.Message(apexpages.severity.CONFIRM,'OTP is resend please check..');
                            apexpages.addmessage(msg);
                            pageReference pg=new pageReference('/apex/TripPandaAuthPAge?id='+tpuserId);
                            pg.setRedirect(true); 
                            return pg; 
                        }
                        }
                }
            }
        return null;
    }
     
}