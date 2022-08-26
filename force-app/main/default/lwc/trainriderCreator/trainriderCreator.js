import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS =[
    'Pratham_Society_Bill_Generation__c.Bill_Number__c',
    'Pratham_Society_Bill_Generation__c.Total_Amount__c',
    'Pratham_Society_Bill_Generation__c.Name_of_Member__c'
]

export default class TrainriderCreator extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    praSoc;

    /*eslint-disable no-console*/
    //console.log('praSoc -->'+JSON.stringify(this.praSoc));
   
    get billNumber(){
        return this.praSoc.data.fields.Bill_Number__c.value;
    }

    get totalAmount() {
        return this.praSoc.data.fields.Total_Amount__c.value;
    }

    get nameOfMember() {
        return this.praSoc.data.fields.Name_of_Member__c.value;
    }


}