public without sharing class OTPBasedLoginController{

    public Lead objLead{get;set;}
    public List<Lead> lst{get;set;}
    public Integer otp{get;set;}
    public OTPBasedLoginController(){
    
     objLead=new Lead();
     lst=new List<Lead>();
     otp=0;
     if(objLead.Email!=null && objLead.Password__c!=null){
        
      LoginToMyPage();
     }else{
     
       System.debug('Not found');
     }
    }
   
    public pageReference LoginToMyPage(){
        
      System.debug('Enter in Login');
      if(!String.IsBlank(objLead.Email) && !String.IsBlank(objLead.Password__c)){
         lst=[select Id,FirstName,LastName,OTP__c from Lead where Email=:objLead.Email and Password__c=:objLead.Password__c];
        
        if(lst.size() > 0){
         
           objLead.id = lst[0].id;
          
           if(objLead.OTP__c !=null){
           List<Lead> updateLead=new List<Lead>();
            for(Lead ld:lst){
           
              ld.OTP__c =null;
              updateLead.add(ld);
            }
             update updateLead;
           }
           otp = randomWithLimit(100000);
           objLead.OTP__c = otp;
           update objLead;
           
           pageReference pg=new pageReference('/apex/OTPBasedAuthPage?id='+objLead.id);
           pg.setRedirect(true); 
           return pg;  
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
        
       if(objLead.OTP__c !=null){
         lst=[select Id,FirstName,LastName,OTP__c from Lead where OTP__c=:objLead.OTP__c];
        
         if(lst.size() > 0){
           
           objLead.id = lst[0].id;
           pageReference pg=new pageReference('/apex/StudentIndexPage?id='+objLead.id);
           pg.setRedirect(true); 
           return pg;  
           
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
    
    public Integer randomWithLimit(Integer upperLimit){
        Integer rand = Math.round(Math.random()*10000);
        return Math.mod(rand, upperLimit);
    }
    
}