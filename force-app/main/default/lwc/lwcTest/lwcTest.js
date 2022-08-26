/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';

export default class LwcTest extends LightningElement {

    @track firstName;
    @track lastName;
    @track showDetails;
    @track contacts;
    @track storyValue = 'Ghost Story';

    handleName(event){
        if(event.target.name === 'firstName'){
            this.firstName = event.target.value;
        }else if(event.target.name === 'lastName'){
            this.lastName = event.target.value;
        }
    }


    checkShowDetailsValue(event){
        this.showDetails = event.target.checked;
    }

    contacts = [
        {
            id : 1,
            Name : 'shujsdaf',
            Title : 'afdsfe fdgerg'
        },
        {
            id : 2,
            Name : 'zfcdsfds',
            Title : 'dfdsf fdgerg'
        },
        {
            id : 3,
            Name : 'eytrytry',
            Title : 'iytews fdgerg'
        }
    ]

    changeTrackPropValue(){
        this.storyValue = 'JOKER ;)';
        console.log('Story Value is '+this.storyValue);
        
    }
    get upperCaseNameValue(){
        return `${this.firstName} ${this.lastName}`.toUpperCase();
    }    



}