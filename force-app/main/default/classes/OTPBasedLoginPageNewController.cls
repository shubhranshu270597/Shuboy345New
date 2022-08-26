/**
 * @File Name          : OTPBasedLoginPageNewController.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 12/4/2019, 7:31:44 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/4/2019   shubhranshu     Initial Version
**/
public without sharing class OTPBasedLoginPageNewController{

    public Lead objLead{get;set;}
    public String Mobile{get;set;} 
    public List<Lead> lst{get;set;}
    public String result{get;set;}
    public String OTP{get;set;}
    public String objLeadId{get;set;}
    
    public OTPBasedLoginPageNewController(){
    
        objLead = new Lead();
        Mobile ='';
        lst= new List<Lead>();
        result = null;
        OTP ='';
        objLeadId= ApexPages.currentPage().getParameters().get('id');
        if(OTP==null){
        
           retryOTP();
        }
    }
    
    public pageReference LoginToMyPage(){
        
        if(!String.IsBlank(objLead.Email) && !String.IsBlank(objLead.Password__c)){
            
          lst=[select Id,FirstName,LastName,MobilePhone,Email,Password__c from Lead where Email=:objLead.Email and Password__c=:objLead.Password__c];
        
          if(lst.size() > 0){
            
            objLead = lst[0];
            Mobile =objLead.MobilePhone;
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
                          pageReference pg=new pageReference('/apex/OTPBasedAuthNewPage?id='+objLead.id);
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
        
        if(!String.IsBlank(OTP)){
            
         List<Lead> authLst=[select Id,MobilePhone from Lead where Id=:objLeadId];
        
           if(authLst.size() > 0){
            
            objLead=authLst[0];
            Mobile =objLead.MobilePhone;
            System.debug('Mobile in Verify OTP Method'+Mobile+' OTP-->'+OTP+' objLeadId-->'+objLeadId);
            
            if(String.isNotBlank(Mobile) && String.isNotBlank(OTP)){
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
                        pageReference pg=new pageReference('/apex/StudentIndexPage?id='+objLeadId);
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
        List<Lead> retryLst=[select Id,MobilePhone from Lead where Id=:objLeadId];
        
           if(retryLst.size() > 0){
            
            objLead=retryLst[0];
            Mobile =objLead.MobilePhone;
            System.debug('Mobile in Retry OTP Method'+Mobile+' objLeadId-->'+objLeadId);
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
                           pageReference pg=new pageReference('/apex/OTPBasedAuthNewPage?id='+objLeadId);
                           pg.setRedirect(true); 
                           return pg; 
                       }
                    }
              }
        }
           return null;
      }
}