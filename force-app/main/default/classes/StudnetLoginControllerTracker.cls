@isTest(SeeAllData=true)
public class StudnetLoginControllerTracker{
 
 public static Lead objLead;
 public static Lead objLead1;
 public static testMethod void loginTest(){
 
   objLead=new Lead();
   objLead.FirstName='test123';
   objLead.LastName='test123';
   objLead.Company='testCompany123';
   objLead.Email='test123@gmail.com';
   objLead.Password__c='1234';
   
   insert objLead;

     StudnetLoginController slc=new StudnetLoginController();
     slc.ld=objLead;
     slc.Login();
 
   objLead1=new Lead();
   objLead1.FirstName='test123';
   objLead1.LastName='test123';
   objLead1.Company='testCompany123';
     
    insert objLead1;
    
     StudnetLoginController slc1=new StudnetLoginController();
     slc1.ld=objLead1;
     slc1.Login();
 }
 
}