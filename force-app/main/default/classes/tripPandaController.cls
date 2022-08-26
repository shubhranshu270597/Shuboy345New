/**
 * @File Name          : tripPandaController.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 09-18-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    15/12/2019   shubhranshu     Initial Version
**/
public without sharing class tripPandaController {

    @AuraEnabled
    public static List<Reimbursement__c> saveDetails(List<Reimbursement__c> reimbur,String tpuserId,String tripName){
        System.debug('reimbur '+reimbur+' tpuserId '+tpuserId);
        List<Reimbursement__c> lstReimburToInsert = new List<Reimbursement__c>();
        if(String.isNotBlank(tpuserId)){
            try{    
                for(Reimbursement__c r: reimbur){
                    r.TripPandaUser__c = tpuserId;
                    r.Trip_Name__c = tripName;
                    lstReimburToInsert.add(r);
                }
                if(lstReimburToInsert.size() >0){   
                    insert lstReimburToInsert;
                    System.debug('Inserted...'+lstReimburToInsert);
                }
            }catch(Exception e){
                throw new AuraHandledException(e.getMessage());
            }
        }
        return lstReimburToInsert;
    }

    @AuraEnabled(Cacheable = true)       
    public static Map<String,String> getPickListValuesForTPUser(){
        Map<String,String> pickMapOfListValues = new  Map<String,String>();
        List<TripPandaUser__c> lstOfTPUser = [SELECT Id,TP_Name__c,UserName__c FROM TripPandaUser__c WHERE UserName__c !=null ORDER BY Name ASC];
        System.debug('lstOfTPUser--'+lstOfTPUser);
        if(lstOfTPUser.size() > 0){
            for(TripPandaUser__c objTPUser : lstOfTPUser){
                pickMapOfListValues.put(objTPUser.Id,objTPUser.TP_Name__c);
            }
        }  
        return pickMapOfListValues;
    }

    @AuraEnabled
    public static List<Reimbursement__c> getReimbursementDetails(String tpUserID) {
        System.debug('getReimbursementDetails with id '+tpUserID);
        return [select Id,Amount__c,Description__c,Reimbursement_name__c,Other_Type__c,Email__c,Reimbursement_requested_by__c, Reimbursement_type__c,TripPandaMemberName__c,TripPandaMemberName__r.TP_Name__c,TripPandaMemberName__r.Total_amount_to_pay__c,TripPandaUser__c,User_Email__c
                 FROM Reimbursement__c where TripPandaMemberName__c =:tpUserID ORDER BY createdDate ASC];
    }

    @AuraEnabled
    public static TripPandaUser__c getTPuserDetails(String tpUserID) {
        System.debug('getTPuserDetails with id '+tpUserID);
        return [select Id,TP_Name__c,Total_amount_to_pay__c,UserName__c,Quotes__c,MobileNumber__c,Gender__c,Profile_Image_Url__c from TripPandaUser__c where Id =:tpUserID LIMIT 1];
    }

    @AuraEnabled
    public static TripPandaConfiguration__c getTPConfiguration(String tpConfigId) {
        String query = getQueryAllFieldSql('TripPandaConfiguration__c','TripPanda_Config_Id__c =: tpConfigId LIMIT 1','');
        System.debug('query-->'+query);
        List<TripPandaConfiguration__c> lst = (List<TripPandaConfiguration__c>) DataBase.query(query);
        return lst[0];
    }

    @AuraEnabled
    public static List<TPUsersConfiguration__c> getTPUserConfiguration(String tpConfigId) {
        String query = getQueryAllFieldSql('TPUsersConfiguration__c','TripPandaConfiguration__c =: tpConfigId','TripPandaUser__r.Id,TripPandaUser__r.UserName__c,TripPandaUser__r.TP_Name__c,TripPandaUser__r.Quotes__c,TripPandaUser__r.MobileNumber__c,TripPandaUser__r.Gender__c,TripPandaUser__r.Profile_Image_Url__c');
        System.debug('query-->'+query);
        List<TPUsersConfiguration__c> lst = (List<TPUsersConfiguration__c>) DataBase.query(query);
        return lst;
    }

    @AuraEnabled
    public static List<Reimbursement__c> getReimbursement(String tpName,String tpUserId) {
        System.debug('tpName '+tpName+' tpUserId '+tpUserId);
        String query = getQueryAllFieldSql('Reimbursement__c','Trip_Name__c =: tpName and Reimbursement_assigned_to_Id__c =:tpUserId','TripPandaUser__r.Id,TripPandaUser__r.UserName__c,TripPandaUser__r.TP_Name__c');
        System.debug('query getReimbursement-->'+query);
        List<Reimbursement__c> lst = (List<Reimbursement__c>) DataBase.query(query);
        System.debug('getReimbursement '+lst);
        return lst;
    }
    
    @AuraEnabled
    public static List<Reimbursement__c> getReimbursementRaised(String tpName,String tpUserId) {
        System.debug('tpName '+tpName+' tpUserId '+tpUserId);
        String query = getQueryAllFieldSql('Reimbursement__c','Trip_Name__c =: tpName and Reimbursement_requested_to_Id__c =:tpUserId','TripPandaUser__r.Id,TripPandaUser__r.UserName__c,TripPandaUser__r.TP_Name__c');
        System.debug('query getReimbursementRaised-->'+query);
        List<Reimbursement__c> lst = (List<Reimbursement__c>) DataBase.query(query);
        System.debug('getReimbursementRaised '+lst);
        return lst;
    }

    @AuraEnabled
    public static List<Reimbursement_Payment__c> getReimbursementPaymentDetaisl(String tpName,String tpUserId) {
        List<Reimbursement_Payment__c> lst = [SELECT Id,Name,TripPandaUser_Requested_TP_user__c,TripPandaUser_Assigned_TP_user__c,Amount__c,Requested_TP_username__c,Trip_Name__c FROM Reimbursement_Payment__c WHERE TripPandaUser_Assigned_TP_user__r.Id =:tpUserId];
        List<TPUsersConfiguration__c> Tpuclst = [SELECT Id,TripPandaConfiguration__c,TripPandaConfiguration__r.Trip_Title__c, TripPandaUser__c FROM TPUsersConfiguration__c WHERE TripPandaConfiguration__r.Trip_Title__c =:tpName];
        List<Reimbursement_Payment__c> filterLst = new List<Reimbursement_Payment__c>();
        if(Tpuclst.size() >0){
            for(TPUsersConfiguration__c tpc:Tpuclst){
                for(Reimbursement_Payment__c rp:lst){
                    if(tpc.TripPandaUser__c == rp.TripPandaUser_Requested_TP_user__c && tpc.TripPandaConfiguration__r.Trip_Title__c == rp.Trip_Name__c){
                        filterLst.add(rp);
                    }
                }
            }
        }else{
            System.debug('No Tp Members found for this trip');
        }
        System.debug('filterLst '+filterLst);
        if(filterLst.size() >0){
            return filterLst;
        }
        return null;
    }

    @AuraEnabled
    public static List<Story_timeline__c> getStorytimeline(String tpConfigId) {
        String query = getQueryAllFieldSql('Story_timeline__c','TripPandaConfiguration__c =: tpConfigId','TripPandaUser__r.Id,TripPandaUser__r.UserName__c,TripPandaUser__r.TP_Name__c,TripPandaUser__r.Quotes__c,TripPandaUser__r.MobileNumber__c,TripPandaUser__r.Gender__c,TripPandaUser__r.Profile_Image_Url__c');
        System.debug('query-->'+query);
        List<Story_timeline__c> lst = (List<Story_timeline__c>) DataBase.query(query);
        return lst;
    }
    
    @AuraEnabled
    public static String addCommentsForStroryLine(String tpConfigId,String tpUserId,String Comments) {
        String result = '';
        if(String.isNotBlank(tpConfigId) && String.isNotBlank(tpUserId) && String.isNotBlank(Comments)){
            try{
                Story_timeline__c st = new Story_timeline__c();
                st.Comments__c = Comments;
                st.TripPandaConfiguration__c = tpConfigId;
                st.TripPandaUser__c = tpUserId;

                insert st;
                result = 'Comment has added in story timeline';
            }catch(DMLException e){
                System.debug(e.getMessage());
                result = e.getMessage();
            }
        }else{
            result = 'Mandatory parameters are missing';
        }
        return result;
    }
    public static String getQueryAllFieldSql(String SObjectAPIName,String conditionString,String relatedField){
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