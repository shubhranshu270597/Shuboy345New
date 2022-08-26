/**
 * @File Name          : accountController.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 8/30/2019, 6:50:28 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/30/2019   shubhranshu     Initial Version
**/
public with sharing class accountController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> getAccountList(){
        String Query = 'Select Id,Name,Phone ,Industry,Website, AccountNumber From Account Limit 5';
        return Database.query(Query); 
    }
}