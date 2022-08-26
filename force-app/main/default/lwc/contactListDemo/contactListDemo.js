import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/ContactAuraService.getContactList';
import getAccountList from '@salesforce/apex/ContactAuraService.getAccountList';

export default class ContactListDemo extends LightningElement {
    @track searchKey;
    @track searchKeyAcc;
    @track contacts;
    @track error;

    @track accounts;
    @track errorAcc;

    @track selectedAccount;
    @wire(getContactList, {
        name: '$searchKey'
    })

    listOfConatcts({ error, data }) {
        if (data) {
            this.contacts = data;
        }

        if (error) {
            this.error = error;
            /* eslint-disable no-console */
            console.log('error ', error);
        }
    }

    findContact(event) {
        event.preventDefault();
        /* eslint-disable no-console */
        console.log('Value ' + event.target.value);
        console.log(this.contacts);
        this.searchKey = event.target.value;
    }

    lstAccount(event) {
        event.preventDefault();
        /* eslint-disable no-console */
        console.log('Value ' + event.target.value);
        console.log(this.accounts);
        this.searchKeyAcc = event.target.value;
    }

    /* eslint-disable no-console */
    findAccount() {
        getAccountList({
            name: this.searchKeyAcc
        })
            .then(result => {
                console.log('result ', result);
                this.accounts = result;
            })
            .catch(error => {
                console.log('error ', error);
                this.errorAcc = error;
            });
    }

    handleSelectRec(event){
        const recordId = event.detail;
        console.log('recordId ', recordId); 

        // this.selectedAccount = this.accounts.find( account => account.Id === recordId);
        
        for(let i=0; i<this.accounts.length; i++){
            if(this.accounts[i].Id  === recordId){
                this.selectedAccount = this.accounts[i];
            }
        }
    }
}