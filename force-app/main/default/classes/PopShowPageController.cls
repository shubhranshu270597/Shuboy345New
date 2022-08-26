public without sharing class PopShowPageController{

    public Lead ld{get;set;}
    public String LeadId{get;set;}
    public PopShowPageController(){
    
       ld=new Lead();
       LeadId=ApexPages.currentPage().getParameters().get('id');
       
       if(LeadId!=Null || LeadId!=''){
           QueryLeadData();
       }
    }
    
    public String getQueryAllFieldSql(String SObjectAPIName,String conditionString){
    
        Map < String, schema.SObjectType > scemapMap = schema.getGlobalDescribe();
        Map < String, schema.SObjectField > fieldMap = scemapMap.get(SObjectAPIName).getDescribe().fields.getMap();
        List <String> fieldNames = new List <String> (fieldMap.keySet());
        
        String query = 'Select '+String.join( fieldNames, ',') +' from '+ SObjectAPIName +' where '+conditionString;
        
        return query;
    }
    
    
    public void QueryLeadData(){
        
      String query = getQueryAllFieldSql('Lead',' id =:LeadId');
      System.debug('query-->'+query);
      List<Lead> lst = (List<Lead>) DataBase.query(query);
     
        if(lst.size()>0){
            
            ld= lst[0];
            System.debug('ld-->'+ld);
        }
    }
    


}