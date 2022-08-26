import { LightningElement, track } from 'lwc';
import getContactList from '@salesforce/apex/auraServiceForAccountCrud.getContactList';

export default class ConList extends LightningElement {
    @track contacts;
    
    contactPrmoise = getContactList();

    connectedCallback(){
        getContactList().then(result =>{
            this.contacts = result;
        })
    }
}