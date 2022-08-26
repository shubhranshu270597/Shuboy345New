import { LightningElement, track } from 'lwc';

export default class TrainRiderCrudOperation extends LightningElement {

    @track trName;

    /*eslint-disable no-console */
    handleChange(event){
        console.log(this.trName);
        this.trName = event.target.value;
    }

}