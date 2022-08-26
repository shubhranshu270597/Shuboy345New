import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/auraServiceForAccountCrud.getAccounts';
export default class AccountData extends LightningElement {
    @track selectedAccount;

    @wire(getAccounts) accounts;

    accountSelected(event) {
        const accountId = event.detail;
        this.selectedAccount = this.accounts.data.find(account => account.Id === accountId);
    }

    get listIsNotEmpty() {
        return this.accounts && Array.isArray(this.accounts.data) && this.accounts.data.length > 0;
    }
}