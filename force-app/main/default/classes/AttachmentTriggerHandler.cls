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
public without sharing class AttachmentTriggerHandler{

    public static void updateAttachmentId(List<Attachment> attachment){

        List<TripPandaUser__c> lstTpUser =new List<TripPandaUser__c>();
        List<Story_timeline__c> lstStorytimeline =new List<Story_timeline__c>();
        Set<Id> setOfleadId = new Set<Id>();
        Map<String,String> mapOfParentId = new Map<String,String>();
        for(Attachment att : attachment){
            if(att.ParentId.getSobjectType() == TripPandaUser__c.SobjectType || att.ParentId.getSobjectType() == Story_timeline__c.SobjectType){  
                setOfleadId.add(att.ParentId);
                mapOfParentId.put(att.ParentId,att.Id);
            }
        }

        lstTpUser = [select Id,Attachement_Id__c,Profile_Image_Url__c from TripPandaUser__c where Id in : setOfleadId];
        lstStorytimeline = [select Id,Attachement_Id__c from Story_timeline__c where Id in : setOfleadId];
        //List<Lead> checkAttachld = [select id from lead where id in (select parentid from attachment where parent.type = 'lead')];
        List<TripPandaUser__c> updatelstTpUser =new List<TripPandaUser__c>();
        List<Story_timeline__c> updatelstStorytimeline =new List<Story_timeline__c>();

        if(lstTpUser.size()>0){
            for(TripPandaUser__c tp: lstTpUser){
                tp.Attachement_Id__c= mapOfParentId.get(tp.Id) != null ? mapOfParentId.get(tp.Id) : '';
                tp.Profile_Image_Url__c	= mapOfParentId.get(tp.Id) != null ? 'https://vaasaportal-developer-edition.ap4.force.com/servlet/servlet.FileDownload?file='+mapOfParentId.get(tp.Id) : '';
                updatelstTpUser.add(tp);
            }

            if(updatelstTpUser.size()>0){
                update updatelstTpUser;
            }
        }
        if(lstStorytimeline.size()>0){
            for(Story_timeline__c st: lstStorytimeline){
                st.Attachement_Id__c= mapOfParentId.get(st.Id) != null ? mapOfParentId.get(st.Id) : '';
                updatelstStorytimeline.add(st);
            }

            if(updatelstStorytimeline.size()>0){
                update updatelstStorytimeline;
            }
        }
        

    }

}