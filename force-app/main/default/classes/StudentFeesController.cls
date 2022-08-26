public without sharing class StudentFeesController{

   public Lead ld{get;set;}
   public String StudRegNo {get;set;}
   public String program {get;set;}
   public String RegNumber {get;set;}
   public String prog {get;set;}
   public String LeadId{get;set;}
   public StudentFees__c sf{get;set;}
   
   public StudentFeesController(){
       ld=new Lead();
       sf = new StudentFees__c();
       StudRegNo = '';
       program = '';
       LeadId =ApexPages.currentPage().getParameters().get('id');
       RegNumber = ApexPages.currentPage().getParameters().get('StudRegNo');
       prog = ApexPages.currentPage().getParameters().get('program');
       if(StudRegNo!=null && program!=null){
          finalPayFees();
       }
      if(RegNumber !=null && prog !=null){
        loadFeesData();        
      }
   }
    
    public void finalPayFees() {
    
     try{
          
          System.debug('StudRegNo -->'+StudRegNo +'program -->'+program);
          String query = getQueryAllFieldSql('StudentFees__c','Lead__r.StudentRegistrationNo__c =: StudRegNo and Progams__c=:program','Lead__r.FirstName,Lead__r.LastName');
          System.debug('query-->'+query);
          List<StudentFees__c> lst = (List<StudentFees__c>) DataBase.query(query);
          System.debug('lst-->'+lst);
            if(lst.size()>0){
                sf = lst[0];
                System.debug('Name -->'+sf.Lead__r.FirstName+' '+sf.Lead__r.LastName);
                System.debug('sf in finalPayFees-->'+sf);
            }else{
               System.debug('Record not found');
            }
             
          }catch(Exception e){
        
           ApexPages.addMessages(e);
        }
      
    }
   
    public void loadFeesData() {
    
     try{
          
          System.debug('RegNumber -->'+RegNumber +'prog -->'+prog );
          String query = getQueryAllFieldSql('StudentFees__c','Lead__r.StudentRegistrationNo__c =:RegNumber and Progams__c=:prog','Lead__r.FirstName,Lead__r.LastName');
          System.debug('query-->'+query);
          List<StudentFees__c> lst = (List<StudentFees__c>) DataBase.query(query);
          System.debug('lst-->'+lst);
            if(lst.size()>0){
                sf = lst[0];
                System.debug('Name -->'+sf.Lead__r.FirstName+' '+sf.Lead__r.LastName);
                System.debug('sf in finalPayFees-->'+sf);
            }else{
               System.debug('Record not found');
            }
           
          }catch(Exception e){
        
           ApexPages.addMessages(e);
        }
      
    }
  
    public PageReference finalPayFeesPDF(){
   
      try{
            
            pagereference ref=new pagereference('/apex/PayFeesPage?StudRegNo='+StudRegNo+'&program='+program);
            ref.setRedirect(true);
            return ref;      
        }catch(Exception e){
        
           ApexPages.addMessages(e);
        }
        
        return null;
    }
   
     public String getQueryAllFieldSql(String SObjectAPIName,String conditionString,String relatedField){
        Map < String, schema.SObjectType > scemapMap = schema.getGlobalDescribe();
        Map < String, schema.SObjectField > fieldMap = scemapMap.get(SObjectAPIName).getDescribe().fields.getMap();
        List <String> fieldNames = new List <String> (fieldMap.keySet());
        if(relatedField !=null && relatedField !=''){
            fieldNames.add(relatedField);
        }
        String query = 'Select '+String.join( fieldNames, ',') +' from '+ SObjectAPIName +' where '+conditionString;
        return query;
    }
}