/* eslint-disable no-alert */
/*eslint-disable no-console */

import { LightningElement, api, track, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Reimbursement from '@salesforce/schema/Reimbursement__c';
import Retype from '@salesforce/schema/Reimbursement__c.Reimbursement_type__c';
import saveDetails from '@salesforce/apex/tripPandaController.saveDetails';
import getPickListValuesForTPUser from '@salesforce/apex/tripPandaController.getPickListValuesForTPUser';
import getReimbursementDetails from '@salesforce/apex/tripPandaController.getReimbursementDetails';
import getTPuserDetails from '@salesforce/apex/tripPandaController.getTPuserDetails';

export default class TripPandaComp extends LightningElement {

    @api tpId;
    @api parameters;
    @track reimbursement = {Amount__c: '', TripPandaMemberName__c: '',Description__c:'', Reimbursement_name__c: '',Reimbursement_type__c: '', TripPandaUser__c:'',Other_Type__c:''};
    @track typeList;
    @track tpUserOptions = [{ label: "Choose TripPanda User", value: "" }];
    @track message;
    @track error;
    @api reibursementData;
    @api reibursementDataError;
    @track getDetails = false;
    @api Totalamounttopay;
    @track TpUser = { Id: '', TP_Name__c: '', Total_amount_to_pay__c:''};
    connectedCallback(){
        // to set the recordId
        if(Object.prototype.hasOwnProperty.call(this.parameters, 'id')) {
            console.log(this.parameters.id);
            this.tpId = this.parameters.id;
            if(this.tpId){
                this.reimbursement.TripPandaUser__c = this.tpId;
                this.reimbursementDetails();
                this.TPuserDetails();
            }
        }
    }

    // Form input handle change event
    handleName(event){
        let field = event.target.dataset.field;
        if ({}.hasOwnProperty.call(this.reimbursement, field)) {
            this.reimbursement[field] = event.detail.value;
            console.log('reimbursemnet ' + JSON.stringify(this.reimbursement));
            this.customValidation(field);
        }
    }

    // custom validation handle method
    customValidation(field) {
        /*test */
        if (field === 'nm_NameofBoard__c' && this.reimbursement[field] === 'State Boards/Others') {
            console.log('ttt');
        } /*test */
    }

    get checkforOtherType(){
        if(this.reimbursement.Reimbursement_type__c === "Others"){
            return true;
        }
        return false;
    }

    @wire(getObjectInfo, { objectApiName: Reimbursement })
    objectInfo;

    // for Reimbursement_type__c field
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Retype})
        getReimbursementTypeList({ error, data }) {
            if (data) {
                this.typeList = data.values;
            } else if (error) {
                console.error(error);
        }
    }

    // save the details 
    Save(){
        if (!this.formValidate()) {
			return;
		}
        console.log('Reimbursement ' + JSON.stringify(this.reimbursement));

        saveDetails({ reimbur: this.reimbursement, tpuserId: this.tpId })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.reimbursement = {};
                }
                console.log(JSON.stringify(result));
                alert('Reimbursement added successfully !');
                this.reimbursementDetails();
                // console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                console.log("error", JSON.stringify(this.error));
                alert('Error '+error.body.message);
            });
    }

    reimbursementDetails() {
        getReimbursementDetails({
            tpUserID: this.tpId
        })
            .then(result => {
                console.log('result ' + JSON.stringify(result));
                this.reibursementData = result;
                this.getDetails = true;
            })
            .catch(error => {
                console.log('error ' + JSON.stringify(error));
                this.reibursementDataError = error;
            })
    }

    TPuserDetails() {
        getTPuserDetails({
            tpUserID: this.tpId
        })
            .then(result => {
                // console.log('result ' + JSON.stringify(result));
                this.TpUser = result;
                console.log('TpUser ' + JSON.stringify(this.TpUser));

            })
            .catch(error => {
                console.log('error ' + JSON.stringify(error));
            })
    }
    
    
    
    @wire(getPickListValuesForTPUser)
    getTPUserList({ error, data }) {
        if (data) {
            let tpUserValues = [];
            for (let key in data) {
                // Preventing unexcepted data
                if (data.hasOwnProperty(key)) { // Filtering the data in the loop
                    tpUserValues.push({ value: data[key], label: key });
                }
            }

            for (const list of tpUserValues) {
                const option = {
                    value: list.label,
                    label: list.value
                };
                this.tpUserOptions = [...this.tpUserOptions, option];
            }

        } else if (error) {
            console.error(error);
        }

    }

    // to validate the form.
	formValidate() {
		const allValid = [
			...this.template.querySelectorAll('lightning-input, lightning-combobox, lightning-radio-group')
		].reduce((validSoFar, inputCmp) => {
			inputCmp.reportValidity();
			return validSoFar && inputCmp.checkValidity();
		}, true);
		return allValid;
	}
}