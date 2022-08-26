import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
const Fields =['StudentFees__c.Computer_Practical_Fees__c','StudentFees__c.Total_Fees__c','StudentFees__c.Progams__c'];
export default class WireGetDynamicRecord extends LightningElement {

    @api recordId;
    @api studFee;
    @api studFeeError;
    /*eslint-disable no-console */
    @wire(getRecord, {
            recordId : '$recordId' , fields :Fields}
         )
    studentFee({error,data}){

        if(data){
            console.log('data '+JSON.stringify(data));
            this.studFee = data;

        }

        if(error){
            console.log('error '+JSON.stringify(error));
            this.studFeeError = error;
        }
    }

    showProgram(){
        console.log('Progams '+this.studFee.fields.Progams__c.value); 
    }
    get program(){
        return this.studFee.fields.Progams__c.value;
    }
}