/**
 * @File Name          : ContactAuraService.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 9/24/2019, 5:31:02 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    8/8/2019, 12:13:47 PM   shubhranshu     Initial Version
**/
public with sharing class ContactAuraService {
    public ContactAuraService() {

    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getContactList(String name){
        String key = name+'%';
        String Query = 'Select Id,Name, Email, Phone From Contact Where Name LIKE :key';
        return Database.query(Query);
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getAccountList(String name){
        String key = name+'%';
        String Query = 'Select Id,Name,Phone ,Industry,Website, AccountNumber From Account Where Name LIKE :key';
        return Database.query(Query); 
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getLeadList(String name){
        String key = name+'%';
        String Query = 'Select Id,FirstName,LastName,MobilePhone,Email  From Lead Where Name LIKE :key';
        return Database.query(Query);
    }

    
    @AuraEnabled(cacheable=true)
    public static List<SObject> getAccountDetails(Id accId){
        String Query = 'Select Id,Name,Website  From Lead Where Id =:accId';
        return Database.query(Query);
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return  [Select Id,Name, Email, Phone From Contact LIMIT 10];   
    }
}