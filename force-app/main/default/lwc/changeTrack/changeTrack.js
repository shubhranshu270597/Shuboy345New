/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';

export default class ChangeTrack extends LightningElement {
    //@track 
    fruitname = 'apple';

    changeTrackValue(){
        this.fruitname = 'mango';
        console.log(this.fruitname);
        
    }

}