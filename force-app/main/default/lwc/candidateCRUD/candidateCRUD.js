import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CANDIDATE from '@salesforce/schema/Candidate__c';
import FIRST_NAME from '@salesforce/schema/Candidate__c.First_Name__c';
import LAST_NAME from '@salesforce/schema/Candidate__c.Last_Name__c';
export default class CandidateCRUD extends LightningElement {

    @track candidateId;
    first_name = '';
    last_name = '';
    handleNameChange(event){

        if(event.target.name === "firstname"){
            this.candidateId = undefined;
            this.first_name = event.target.value;
        }
        if(event.target.name === "lastname"){
            this.candidateId = undefined;
            this.last_name = event.target.value;
        }
    }


    createCandidate(){
        const fields = {};
        fields[FIRST_NAME.fieldApiName] = this.first_name;
        fields[LAST_NAME.fieldApiName] = this.last_name;
        const recordInput = { apiName: CANDIDATE.objectApiName, fields };
        createRecord(recordInput)
            .then(candidate => {
                this.candidateId = candidate.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Candidate created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
}