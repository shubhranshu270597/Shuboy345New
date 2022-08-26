@isTest(SeeAllData=true)
public class PrathamResidencyControllerTest {
    public static testmethod void testMethod1(){
    Pratham_Society_Bill_Generation__c psbg =new Pratham_Society_Bill_Generation__c();
    psbg.Cidco_Service_Charge__c= 1000;
    psbg.Cultural_Fund__c= 100;
    psbg.Flat_Number__c= '103';
    psbg.Repair_fund__c= 200;
    psbg.Sinking_Fund__c= 500;
 insert psbg;
    PrathamResidencyController prController= new PrathamResidencyController();

  prController.saveAllDetails();  
   
    
     Pratham_Society_Bill_Generation__c psbgg =new Pratham_Society_Bill_Generation__c();
    psbgg.Cidco_Service_Charge__c= 10089;
    psbgg.Cultural_Fund__c= 200;
    psbgg.Flat_Number__c= '100003';
    psbgg.Repair_fund__c= 2000000;
    psbgg.Sinking_Fund__c= 500000;
        insert psbgg;
         prController.saveAllDetails();
      
    }
}