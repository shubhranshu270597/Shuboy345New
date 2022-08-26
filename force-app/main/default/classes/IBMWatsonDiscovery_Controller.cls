/**
 * @File Name          : IBMWatsonDiscovery_Controller.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 12/3/2020, 7:13:24 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/3/2020   shubhranshu     Initial Version
**/
public with sharing class IBMWatsonDiscovery_Controller {
    /**
    * @description 
    * @author shubhranshu | 12/3/2020 
    * @param String name 
    * @return List<Watson_Discovery__x> 
    **/
    @AuraEnabled
    public static List<Watson_Discovery__x> getSearchResults(String name) {
        List<List<SObject>> allResults = [FIND :name IN Name Fields RETURNING Watson_Discovery__x(User__c,Twitter__c) LIMIT 25];
        List<Watson_Discovery__x> results = allResults[0];
        return results;
    }
}