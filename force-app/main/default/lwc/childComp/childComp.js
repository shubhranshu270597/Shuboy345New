/* eslint-disable no-console */
import { LightningElement } from 'lwc';
export default class ChildComponent extends LightningElement {
    
    // @track Message;
    // @api
    // changeMessage(strString) {
    //     this.Message = strString.toUpperCase();
    // }

    handleChange(event){
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name 
        });
       this.dispatchEvent(selectEvent);
    }
}