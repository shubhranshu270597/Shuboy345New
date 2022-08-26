import { LightningElement, api } from 'lwc';
import ACCOUNT_OBJ from '@salesforce/schema/Account';
export default class ViewEditRecord extends LightningElement {

    @api objectApiName = ACCOUNT_OBJ;
    @api recordId;

    /*eslint-disable no-alert */
    handleSubmit(){
        alert('edit form ...');
    }
}