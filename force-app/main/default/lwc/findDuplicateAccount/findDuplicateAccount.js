import { LightningElement, track} from 'lwc';
import getAccountList from '@salesforce/apex/ContactAuraService.getAccountList';

export default class FindDuplicateAccount extends LightningElement {

    @track accName;
    @track accounts;
    @track errorAcc;
    /*eslint-disable no-console */
    lstAccount(event){
        event.preventDefault();
        console.log(event.target.value);
        this.accName = event.target.value;
    }

    // @wire(getAccountList ,{
    //     name: '$accName'
    // })

    // listOfAccounts({error , data}){
    //     if(data){
    //         console.log('data ' + JSON.stringify(data));
    //         this.accounts = data;
    //     }

    //     if(error){
    //         console.log('error ' + JSON.stringfly(error));
    //         this.errorAcc = error;
    //     }
    // }

    findAccounts(){
        getAccountList({
            name : this.accName
        })
        .then( result =>{
            console.log('result ' + JSON.stringify(result));
            this.accounts = result;
        })
        .catch(error => {
            console.log('error ' + JSON.stringify(error));
            this.error= error;
        })
    }
}