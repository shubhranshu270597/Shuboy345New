import { LightningElement } from 'lwc';

export default class Paginator extends LightningElement {

    handleNext(){
        // create the event
        const testmsg = 'this is test next value';
        const nextEvent = new CustomEvent(
                                'next' ,
                                { detail : testmsg}
                                );
        // fire the event
        this.dispatchEvent(nextEvent);
    }

    handlePrev() {
        const testmsg = 'this is test prev value';
        const prevEvent = new CustomEvent('previous' , 
                                        {
                                            detail : testmsg
                                        }
                                            );
        this.dispatchEvent(prevEvent);
    }

}