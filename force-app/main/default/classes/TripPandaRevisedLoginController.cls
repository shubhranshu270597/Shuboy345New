/**
 * @description       : 
 * @author            : shubhranshu
 * @group             : 
 * @last modified on  : 09-24-2020
 * @last modified by  : shubhranshu
 * Modifications Log 
 * Ver   Date         Author        Modification
 * 1.0   09-24-2020   shubhranshu   Initial Version
**/
public with sharing class TripPandaRevisedLoginController {

    public TripPandaUser__c tpUser {get;set;}
    public List<TripPandaUser__c> tpUserList {get;set;}
    public String TPConfigurationId {get;set;}

    public TripPandaRevisedLoginController() {
        tpUser = new TripPandaUser__c();
        tpUserList = new List<TripPandaUser__c>();
        TPConfigurationId = '';
    }

    public Pagereference LoginAndAuthenticate(){

        if(String.isNotBlank(tpUser.UserName__c) && String.isNotBlank(tpUser.Password__c) && String.isNotBlank(TPConfigurationId)){
            tpUserList = [select Id , UserName__c , Password__c , MobileNumber__c from TripPandaUser__c where UserName__c=:tpUser.UserName__c and Password__c=:tpUser.Password__c limit 1 ];

            if(tpUserList.size() > 0){
                tpUser = tpUserList[0];
                pageReference pg=new pageReference('/apex/TripPanda?id='+tpUser.Id+'&TPConfig='+TPConfigurationId);
                pg.setRedirect(true); 
                return pg;
            }else{
                    apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Invalid Credentional..');
                    apexpages.addmessage(msg);
                }
        }else{
            apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please Enter Email Id and Passowrd..');
            apexpages.addmessage(msg);
        }
        return null;
    }
}