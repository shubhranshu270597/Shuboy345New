import { LightningElement, track } from 'lwc';
import getLeadList from '@salesforce/apex/ContactAuraService.getLeadList';

export default class FindDuplicateLead extends LightningElement {

   @track leadName;
   @track leads;
   @track leadError;
   /*eslint-disable no-console */
   findLead(event){
    event.preventDefault();
    console.log('Name '+event.target.value);
    this.leadName = event.target.value;

   }

//    @wire( getLeadList ,{
//        name : '$leadName'
//    })

//    findLeads({error ,data}){

//         if(data){
//             console.log('data '+JSON.stringify(data));
//             this.leads = data;
//         }
//         if(error){
//             console.log('error '+JSON.stringify(error));
//             this.leadError = error;
//         }
//    }


   findDuplicateLeads(){
    getLeadList({
        name : this.leadName
    })
    .then( result =>{
        console.log('result ' + JSON.stringify(result));
        this.leads = result;
    })
    .catch(error => {
        console.log('error ' + JSON.stringify(error));
        this.leadError= error;
    })
}
}