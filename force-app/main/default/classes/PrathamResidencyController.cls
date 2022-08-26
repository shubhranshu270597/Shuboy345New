public without sharing class PrathamResidencyController {
 
    public Pratham_Society_Bill_Generation__c ps{get;set;}
    
    public PrathamResidencyController(){
        
        ps=new Pratham_Society_Bill_Generation__c();
        
    }
    
    public PageReference saveAllDetails(){
        
        try{
            
            System.debug('enter in saveAllDetails');
            insert ps;
            
            System.debug('ps --->'+ps);
            pagereference ref=new pagereference('/apex/TotalBillSummary?id='+ps.id);
            ref.setRedirect(true);
            return ref;
        }catch(Exception e){
            
            ApexPages.addMessages(e);
        }
        return null;
    }
  
    
}