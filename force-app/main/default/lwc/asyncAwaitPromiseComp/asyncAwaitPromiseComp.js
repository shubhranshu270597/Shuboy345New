/* eslint-disable no-console */
/* eslint-disable no-unused-vars */
/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/auraServiceForAccountCrud.getAccounts';
export default class AsyncAwaitPromiseComp extends LightningElement {
    @track isLoaded = false;
    @track acounts;
    @track error;

    /* with promise example  */

    // connectedCallback(){
    //     getAccounts()
    //     .then(result =>{
    //         this.acounts = result;
    //         console.log('1st then '+JSON.stringify(this.acounts));
    //         return this.promiseFunc();
    //     })
    //     .then(value =>{
    //         console.log('2nd then ');
    //     })
    //     .catch(error =>{
    //         this.error = error;
    //         console.log('error '+this.error);
            
    //     })
    //     .finally(() =>{
    //         this.isLoaded = true;
    //     });
    // }

    
    // with aysnc and await example
    connectedCallback(){
        this.init();
    }

    init = async() =>{
        try{
            this.acounts = await getAccounts();
            const value = await this.promiseFunc();
            console.log('2nd then executes after 3 seconds async, value:' + value);
            
        }catch(error){
            this.error = error;
        }finally{
            this.isLoaded = true;
        }
    }

    promiseFunc() {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                resolve('foo');
            }, 3000);
        });
    }

}