/**
 * @File Name          : ReimbursementTrigger.trigger
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 15/12/2019, 3:20:28 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    15/12/2019   shubhranshu     Initial Version
**/
trigger ReimbursementTrigger on Reimbursement__c (after insert,after update, after delete) {
    if(trigger.isAfter && trigger.isInsert)
    {
        ReimbursementTriggerHandler obj = new ReimbursementTriggerHandler();
        obj.AfterInsert(trigger.new, trigger.newMap);
    }
    if(trigger.isAfter && trigger.isUpdate)
    {          
        ReimbursementTriggerHandler obj = new ReimbursementTriggerHandler();
        obj.AfterUpdate(trigger.new, trigger.oldMap);
    }
    if(trigger.isAfter && trigger.isDelete)
    {        
        ReimbursementTriggerHandler obj = new ReimbursementTriggerHandler();
        obj.AfterDelete(trigger.old, trigger.oldMap);
    }
}