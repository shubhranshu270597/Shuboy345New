/**
 * @description       : 
 * @author            : shubhranshu
 * @group             : 
 * @last modified on  : 09-17-2020
 * @last modified by  : shubhranshu
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   09-17-2020   shubhranshu   Initial Version
**/
public without sharing class ReimbursementTriggerHandler {
    public void AfterInsert(List<Reimbursement__c> lstItem , Map<Id,Reimbursement__c> newItemMap) {
        calculateTotalAmountToPay(lstItem,newItemMap);
    }

    public void AfterUpdate(List<Reimbursement__c> lstItem , Map<Id,Reimbursement__c> oldItemMap) {
        calculateTotalAmountToPay(lstItem,oldItemMap);
    }

    public void AfterDelete(List<Reimbursement__c> lstItem , Map<Id,Reimbursement__c> oldItemMap) {
        calculateTotalAmountToPay(lstItem,oldItemMap);
    }

     public void calculateTotalAmountToPay(List<Reimbursement__c> lst,Map<Id,Reimbursement__c> itemMap){
        
        System.debug('lst '+lst);
        
        List<TripPandaUser__c> lstTPusers =new List<TripPandaUser__c>();
        Set<Id> setOfTPuserId = new Set<Id>();
        Decimal totalPrice = 0.0;
        for(Reimbursement__c r : lst){
            setOfTPuserId.add(r.TripPandaMemberName__c);
        }
        System.debug('setOfTPuserId '+setOfTPuserId);
        List<Reimbursement__c> lstreimbursement = [select Id ,Amount__c , TripPandaMemberName__c from Reimbursement__c where TripPandaMemberName__c in : setOfTPuserId];

        System.debug('lstreimbursement '+lstreimbursement.size());
        for(Reimbursement__c reLst:lstreimbursement){
           totalPrice += reLst.Amount__c;
        }
        
        lstTPusers = [select Id,TP_Name__c,Total_amount_to_pay__c from TripPandaUser__c where Id in : setOfTPuserId];
        List<TripPandaUser__c> updateTPuser =new List<TripPandaUser__c>();

        for(TripPandaUser__c tp:lstTPusers){
            
            tp.Total_amount_to_pay__c = totalPrice ;
            updateTPuser.add(tp);
        }


        if(updateTPuser.size() > 0){
            System.debug('updateTPuser '+updateTPuser);
            try {
                update updateTPuser;
            } catch (DmlException e) {
                System.debug(e.getMessage());
            }
        }
    }
}