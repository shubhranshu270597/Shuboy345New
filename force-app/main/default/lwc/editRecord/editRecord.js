import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
// import NAME_FIELD from '@salesforce/schema/Contact.Name';
// import TITLE_FIELD from '@salesforce/schema/Contact.Title';
// import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
// import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

// export default class RecordFormStaticContact extends LightningElement {
//     // Flexipage provides recordId and objectApiName
//     @api recordId;
    // @api objectApiName;

    // fields = [ACCOUNT_FIELD, NAME_FIELD, TITLE_FIELD, PHONE_FIELD, EMAIL_FIELD];

    /* eslint-disable no-console */
    // handleReset(event) {
    //     console.log('enter');
    //     const inputFields = this.template.querySelectorAll(
    //         'lightning-input-field'
    //     );
    //     if (inputFields) {
    //         inputFields.forEach(field => {
    //             field.reset();
    //         });
    //     }
    //  }

export default class FormErrorExample extends LightningElement {

    @api recordId;

    handleError(event){
        console.log(event.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error creating record',
                message: event.detail.message,
                variant: 'error',
            }),
        );
    }
}