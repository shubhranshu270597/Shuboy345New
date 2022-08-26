import { LightningElement,track ,wire} from 'lwc';
import getLeads from '@salesforce/apex/AuraLeadSearch.getLeads';
import deleteLeadsfromOrg from '@salesforce/apex/AuraLeadSearch.deleteLeadsfromOrg';
import getAllLeads from '@salesforce/apex/AuraLeadSearch.getAllLeads';
// importing to show toast notifictions
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

// importing to refresh the apex after delete the records.
import {refreshApex} from '@salesforce/apex';

const columns = [
    {
        label: 'FirstName',
        fieldName: 'FirstName'
    }, {
        label: 'LastName',
        fieldName: 'LastName'
    }, {
        label: 'MobilePhone',
        fieldName: 'MobilePhone',
        type: 'phone'
    }, {
        label: 'Email',
        fieldName: 'Email',
        type: 'email'
    }
];

export default class LeadCRUDOperations extends LightningElement {
    @track leadName;
    @track leads;
    @track leaderror;
    @track columns = columns;
    @track buttonLabel = 'Delete Selected Leads';
    @track isTrue = false;
    @track recordsCount = 0;
    @track lstLeads;
    @track lstLeadsError;
    
     // non-reactive variables
     selectedRecords = [];
     refreshTable;
     error;

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

    @wire(getAllLeads)
    listOfLeads({error , data}){
        this.refreshTable = data;
        if(data){
            console.log('data ' + JSON.stringify(data));
            this.lstLeads = data;
            refreshApex(this.lstLeads);
        }

        if(error){
            console.log('error ' + JSON.stringfly(error));
            this.lstLeadsError = error;
        }
    }

    getSelectedRecords(event) {
        // getting selected rows
        const selectedRows = event.detail.selectedRows;
        
        this.recordsCount = event.detail.selectedRows.length;

        // this set elements the duplicates if any
        let ldIds = new Set();

        // getting selected record id
        for (let i = 0; i < selectedRows.length; i++) {
            ldIds.add(selectedRows[i].Id);
        }

        // coverting to array
        this.selectedRecords = Array.from(ldIds);

        window.console.log('selectedRecords ====> ' +this.selectedRecords);
    }

    deleteLeads() {
        if (this.selectedRecords) {
            // setting values to reactive variables
            this.buttonLabel = 'Processing....';
            this.isTrue = true;

            // calling apex class to delete selected records.
            this.deleteAllSelectedLeads();
        }
    }

    deleteAllSelectedLeads() {
        deleteLeadsfromOrg({lstLeadIds: this.selectedRecords})
        .then(result => {
            window.console.log('result ====> ' + result);

            this.buttonLabel = 'Delete Selected Leads';
            this.isTrue = false;

            // showing success message
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!', 
                    message: this.recordsCount + ' Leads are deleted.', 
                    variant: 'success'
                }),
            );
            
            // Clearing selected row indexs 
            this.template.querySelector('lightning-datatable').selectedRows = [];

            this.recordsCount = 0;

            // refreshing table data using refresh apex
            return refreshApex(this.refreshTable);

        })
        .catch(error => {
            window.console.log(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error while getting Leads', 
                    message: error.message, 
                    variant: 'error'
                }),
            );
        });
    }  
}