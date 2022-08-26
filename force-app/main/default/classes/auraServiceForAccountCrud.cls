/**
 * @File Name          : auraServiceForAccountCrud.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 7/2/2020, 4:45:59 pm
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    8/16/2019, 6:07:41 PM   shubhranshu     Initial Version
**/
public without sharing class auraServiceForAccountCrud {
    public auraServiceForAccountCrud() {

    }

    @AuraEnabled
    public static String createAccount(String name, String industry, String accountNo, String phone, String website){
        Account acc = new Account();
        String result;
        
        acc.Name = name;
        acc.Industry = industry;
        acc.AccountNumber = accountNo;
        acc.Phone= phone;
        acc.Website = website;
        System.debug('acc '+acc);
        if(acc != null){
            try{
                insert acc;
                result = 'Account Created';
                System.debug('Account Created');

            }catch(DmlException e){
                result = 'Failed';
                System.debug(e.getMessage());
            }
        }
        return result;
    }

    public static String updateAccount(Id accid, String name){

        List<Account> lstAcc= [Select Id , Name from Account where Id =:accid];
        List<Account> updateAcc = new List<Account>();
        if(lstAcc.size()>0){
            for(Account acc:lstAcc){
                acc.Name = name;
                updateAcc.add(acc);
            }
        }
        
        String result;

        if(updateAcc.size()>0){
            try{
                
                update updateAcc;
                result = 'Account Updated';
                System.debug('Account Updated');

            }catch(DmlException e){
                result = 'Failed';
                System.debug(e.getMessage());
            }
        }
       
        return result;
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String accId,Decimal amt){
        return [Select Id, Name , Amount From Opportunity Where AccountId =: accId and Amount < :amt];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [Select Id, Name , Industry From Account limit 10];
    }

    @AuraEnabled
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 10];
    }
}