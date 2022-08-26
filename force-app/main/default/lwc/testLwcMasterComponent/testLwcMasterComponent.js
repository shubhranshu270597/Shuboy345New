import { api, LightningElement, track } from 'lwc';

export default class TestLwcMasterComponent extends LightningElement {
    
    @track userName = 'Shubhranshu';

    @track userlist = [{ label: 'user 1', value: '1111' }, 
                       { label: 'user 2', value: '2222' },
                       { label: 'user 3', value: '3333' },
                       { label: 'user 4', value: '4444' }];
    @api choosevalues = [];
    @track selectedPayloadType;
    @track selectedPayloadusers;

    getSelectedValues(event){
        console.log('handle event '+JSON.stringify(event.detail));
        this.selectedusers = event.detail;
        console.log(this.selectedusers.payloadType);
        this.selectedPayloadusers = this.selectedusers.payload;
        console.log(JSON.stringify(this.selectedPayloadusers.values));
    }
}