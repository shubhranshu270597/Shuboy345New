import { LightningElement, api, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/auraServiceForAccountCrud.getOpportunities';
import OppAmount from '@salesforce/label/c.OpportunityAmount';

export default class OpportunityDynamic extends LightningElement {
    @api recordId;
    @api amount;
    @api oppAmt = OppAmount;

    handleChange(event){
        this.amount = event.target.value;
    }
    @wire(getOpportunities , {accId: '$recordId' ,amt :'$amount'})
    opportunities

    
}