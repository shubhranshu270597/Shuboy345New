/**
 * @File Name          : AuraLeadSearch.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 9/6/2019, 7:19:14 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   shubhranshu     Initial Version
**/
public with sharing class AuraLeadSearch {
    public AuraLeadSearch() {

    }

    @AuraEnabled
    public static List<SObject> getLeads(String name){

        String keySearch = '%'+name+'%';
        String leadQuery = 'select Id,FirstName,LastName, MobilePhone, Email from Lead where FirstName Like :keySearch';

        return Database.query(leadQuery);
    }

    @AuraEnabled
    public static void deleteLeadsfromOrg(list<Id> lstLeadIds){
        try {
            list<Lead> lstleadsToDelete = new list<Lead>();
            System.debug('lstLeadIds ====> '+lstLeadIds);
            for(Id idLd : lstLeadIds) {
                lstleadsToDelete.add(new Lead(Id = idLd));
            }
            if(!lstleadsToDelete.isEmpty()) {
                delete lstleadsToDelete;
            }
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled(Cacheable = true)
    public static List<Lead> getAllLeads(){
        return [SELECT Id, FirstName,LastName, MobilePhone, Email FROM Lead ORDER BY Name limit 100];
    }
}