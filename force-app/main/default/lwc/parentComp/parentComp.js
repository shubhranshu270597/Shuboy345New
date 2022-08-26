/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';

export default class ParentComp extends LightningElement {

    // handleChangeEvent(event){
    //     this.template.querySelector('c-child-Comp').changeMessage(event.target.value);
    // }

    @track msg;
    handleCustomEvent(event) {
        const textVal = event.detail;
        this.msg = textVal;
    }
}