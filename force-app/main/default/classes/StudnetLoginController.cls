public without sharing class StudnetLoginController{
    
    public Lead ld{get;set;}
    public List<Lead> lst{get;set;}
    public String LeadId{get;set;}
    public StudnetLoginController(){
    
        ld=new Lead();
        lst=new List<Lead>();
        LeadId = ApexPages.currentPage().getParameters().get('id');

    }
    
    
    public pageReference Login(){
        
      if(!String.IsBlank(ld.Email) && !String.IsBlank(ld.Password__c)){
         lst=[select ID,FirstName,LastName from Lead where Email=:ld.Email and Password__c=:ld.Password__c];
        
        if(lst.size() > 0){
           
           ld.id = lst[0].id;
           pageReference pg=new pageReference('/apex/StudentIndexPage?id='+ld.id);
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
    /*
    public pageReference goToFeesPage(){
        
         pageReference pg=new pageReference('/apex/StudentFeesPage?id='+LeadId);
         pg.setRedirect(true); 
         return pg;  
    
    }
    */  
}