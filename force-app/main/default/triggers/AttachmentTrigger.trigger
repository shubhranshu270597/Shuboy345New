/**
 * @description       : 
 * @author            : shubhranshu
 * @group             : 
 * @last modified on  : 07-21-2020
 * @last modified by  : shubhranshu
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   07-21-2020   shubhranshu   Initial Version
**/
trigger AttachmentTrigger on Attachment (after insert,after update) {

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        AttachmentTriggerHandler.updateAttachmentId(Trigger.new);
    }

}