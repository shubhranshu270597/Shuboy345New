import { LightningElement, api } from 'lwc';

export default class CurrentDateTime extends LightningElement {

    @api todayDate;
    todayDate = new Date().toDateString();
}