import { LightningElement, track } from 'lwc';
import { createRecord, updateRecord, deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountCreator extends LightningElement {

    @track accountId;
    @track accountName;
    @track account;

    /*eslint-disable no-console */
    handleChange(event) {
        console.log(event.target.value);
        this.accountName = event.target.value;
    }

    saveAccountRec() {
        console.log(this.accountName);
        console.log(this.accountId);
        if(this.accountId == null || this.accountId === "") {
            console.log('createAcount called');
            this.createAccount();
        } else {
            console.log('updateAcount called');
            this.updateAccount();
        }
    }    

    createAccount() {
        
        console.log('createAccount enter...');
        const fields = {};
        fields[ACCOUNT_NAME_FIELD.fieldApiName] = this.accountName;
        console.log('this.accountName: ' + this.accountName);
        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(Account => {
                console.log('createAccount SAVED');
                console.log(JSON.stringify(Account));
                this.accountId = Account.id;
                this.accountName = Account.fields.Name.value;   

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                );
            })
            .catch(error => {
                console.log(JSON.stringify(error));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating account ERROR',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
    
    updateAccount() {
        console.log('updateAccount');
        let record = {
              fields: {
                  Id: this.accountId,
                  Name:this.newAccountName
                },
          };
  
          updateRecord(record)
              .then(() => {
                  this.dispatchEvent(
                      new ShowToastEvent({
                          title: 'Success',
                          message: 'Account Updated',
                          variant: 'success',
                      }),
                  );
              })
              .catch(error => {
                  this.dispatchEvent(
                      new ShowToastEvent({
                          title: 'Error updating account',
                          message: error.message.body,
                          variant: 'error',
                      }),
                  );
              });        
      }


      deleteAccount() {
          
        deleteRecord(this.accountId)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account Deleted',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error deleting account',
                    message: error.message.body,
                    variant: 'error',
                }),
            );
        });   


      }

}