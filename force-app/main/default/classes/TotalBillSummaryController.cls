public without sharing class TotalBillSummaryController {

    public String billId {get;set;}
    public String flatNumber {get;set;}
    public String flatNum {get;set;}
    public Pratham_Society_Bill_Generation__c psbg {get;set;}
    
    public TotalBillSummaryController(){
        
        billId=ApexPages.currentPage().getParameters().get('id');
        flatNum=ApexPages.currentPage().getParameters().get('flatNumber');
        flatNumber ='';
      
        psbg=new Pratham_Society_Bill_Generation__c();
        if(billId !=null && billId != ''){
            QueryLeadData();
       }
       if(flatNum !=null && flatNum !=''){
       
           FinalBillReceipt();
       }
      
    }
    public PageReference BillReceipt(){
   
      try{
            
            pagereference ref=new pagereference('/apex/BillReceipt?id='+billId);
            ref.setRedirect(true);
            return ref;      
        }catch(Exception e){
        
           ApexPages.addMessages(e);
        }
        
        return null;
    }

    public PageReference FinalBillReceipt(){
   
      try{
              System.debug('flatNum-->'+flatNumber);
              String query = getQueryAllFieldSql('Pratham_Society_Bill_Generation__c',' Flat_Number__c=:flatNum');
              System.debug('query-->'+query);
              List<Pratham_Society_Bill_Generation__c> lstPs1 = (List<Pratham_Society_Bill_Generation__c>) DataBase.query(query);
              System.debug('lstps1-->'+lstPs1);
                if(lstPs1.size()>0){
                    psbg = lstPs1[0];
                    System.debug('psbg in searchBillData-->'+psbg);
                }else{
                   System.debug('Record not found');
                }
        
            pagereference ref=new pagereference('/apex/BillReceipt?flatNumber='+flatNumber);
            ref.setRedirect(true);
            return ref;      
        }catch(Exception e){
        
           ApexPages.addMessages(e);
        }
        
        return null;
    }
  
    public String getQueryAllFieldSql(String SObjectAPIName,String conditionString)
    {
        Map < String, schema.SObjectType > scemapMap = schema.getGlobalDescribe();
        Map < String, schema.SObjectField > fieldMap = scemapMap.get(SObjectAPIName).getDescribe().fields.getMap();
        List <String> fieldNames = new List <String> (fieldMap.keySet());
        
        String query = 'Select '+String.join( fieldNames, ',') +' from '+ SObjectAPIName +' where '+conditionString;
        
        return query;
    }
    
    
    public void QueryLeadData(){
        
      String query = getQueryAllFieldSql('Pratham_Society_Bill_Generation__c',' id =:billId');
      System.debug('query-->'+query);
      List<Pratham_Society_Bill_Generation__c> lstPs = (List<Pratham_Society_Bill_Generation__c>) DataBase.query(query);
     
        if(lstPs.size()>0){
            
            psbg = lstPs[0];
        }
    }
    

    public void searchBillData(){
      System.debug('flatNumber-->'+flatNumber);
      String query = getQueryAllFieldSql('Pratham_Society_Bill_Generation__c',' Flat_Number__c=:flatNumber');
      System.debug('query-->'+query);
      if(!String.IsBlank(flatNumber) && !String.IsBlank(flatNumber)){
      
          List<Pratham_Society_Bill_Generation__c> lstPs1 = (List<Pratham_Society_Bill_Generation__c>) DataBase.query(query);
          System.debug('lstps1-->'+lstPs1);
            if(lstPs1.size()>0){
                
                psbg = lstPs1[0];
                System.debug('psbg in searchBillData-->'+psbg);
            }else{
               System.debug('Record not found');
            }
       }else{
       
         System.debug('---flatNumber----'+flatNumber);
       }            
    }

}