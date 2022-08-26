import { LightningElement ,api } from 'lwc';
import ACCOUNT_OBJ from '@salesforce/schema/Account';

export default class CreateRecordForm extends LightningElement {
@api accountObject = ACCOUNT_OBJ;

    handleAccountCreated(){
        alert("Account created....");
    }
}