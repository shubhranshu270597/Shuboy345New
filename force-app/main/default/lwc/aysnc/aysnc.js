import { LightningElement, track, api } from 'lwc';

export default class Aysnc extends LightningElement {

    @track value;
    @track error;
    @track pending = true;

    @api promise;

    connectedCallback(){
        this.promise
        .then(value =>{
            this.value = value
        })
        .catch(error =>{
            this.error = error
        })
        .finally(() =>{
            this.pending = false
        });
    }
}