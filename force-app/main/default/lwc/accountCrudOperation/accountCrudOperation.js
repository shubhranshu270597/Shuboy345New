import { LightningElement, track } from 'lwc';
import createAccount from '@salesforce/apex/auraServiceForAccountCrud.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TrainRiderCrudOperation extends LightningElement {

    @track accName;
    @track industry;
    @track accNumber;
    @track phone;
    @track website;
    @track accError;
    @track result ;
    /*eslint-disable no-console */
    handleChange(event){
        console.log(this.accName);
        this.accName = event.target.value;
    }
    handleChange2(event){
        console.log(this.industry);
        this.industry = event.target.value;
    }
    handleChange3(event){
        console.log(this.accNumber);
        this.accNumber = event.target.value;
    }
    handleChange4(event){
        console.log(this.phone);
        this.phone = event.target.value;
    }
    handleChange5(event){
        console.log(this.website);
        this.website = event.target.value;
    }

    createAccountLwc(){
        createAccount({
            name : this.accName,
            industry : this.industry,
            accountNo : this.accNumber,
            phone : this.phone,
            website : this.website
        })
        .then(success =>{
            this.result = success;
            console.log('success '+ JSON.stringify(success));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: JSON.stringify(success),
                    variant: 'success',
                }),
            );
    
        })
        .catch(error =>{
          this.accError = error;
          console.log('erorr '+ JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating account ERROR',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );
        })
    }

}