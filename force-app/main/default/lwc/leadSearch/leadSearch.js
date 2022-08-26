import { LightningElement, track } from 'lwc';
import getLeads from '@salesforce/apex/AuraLeadSearch.getLeads';

export default class LeadSearch extends LightningElement {

    @track leadName;
    @track leads;
    @track leaderror;

    /*eslint-disable no-console */
    findLead(event){
        event.preventDefault();
        console.log('Name '+event.target.value);
        this.leadName = event.target.value;
    }

    findLeadSearch(){
        getLeads({
            name : this.leadName
        })
        .then( result =>{
            console.log('result '+JSON.stringify(result));
            this.leads = result;
        })
        .catch(error =>{
            console.log('error '+JSON.stringify(error));
            this.leaderror = error;
        })
    }
}