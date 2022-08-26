import { LightningElement, api, wire } from 'lwc';
// import getAccountDetails from '@salesforce/apex/ContactAuraService.getAccountDetails';
// import getAccountList from '@salesforce/apex/accountController.getAccountList';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord ,getFieldValue } from 'lightning/uiRecordApi';
import AccName from '@salesforce/schema/Account.Name';
import AccEmail  from '@salesforce/schema/Account.Website';
let fields  = [ AccName ,AccEmail ];

export default class SalesforceModuleDemo extends NavigationMixin(LightningElement){

    // @wire(getAccountList) accounts;   

    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields })
    accounts;

    get name() {
        return getFieldValue(this.accounts.data, AccName);
    }
    /*eslint-disable no-console */
    get email() {
        return getFieldValue(this.accounts.data, AccEmail);
    }

    
    /*eslint-disable no-console */
    navigateToWebPage() {

        let redirectURL = "http://sandbox-ngasce.cs5.force.com/nmlogin_new?Name="+this.name+"&Email="+this.email;
        console.log('redirectURL '+redirectURL);
        
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": redirectURL
            }
        });
    }
}