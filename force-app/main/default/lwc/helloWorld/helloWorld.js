import { LightningElement, track } from 'lwc';
import LightningConfirm from "lightning/confirm";
import lightningPrompt from 'lightning/prompt';
export default class HelloWorld extends LightningElement {
    @track greeting = 'World';
    confirmasked = false;
    changeHandler(event) {
        this.greeting = event.target.value;
        this.confirmasked = false;
    }
    async confirmcheck(e){
        if(!this.confirmasked){
            const result = await LightningConfirm.open({
                message: "Are you sure you want to change the existing name?",
                variant: "default", // headerless
                label: "Change Name",
                theme: "alt-inverse"
            });
            console.log('result '+result);
            //Confirm has been closed
        
            //result is true if OK was clicked
            if (result) {
                // this.greeting = e.target.value;
                this.confirmasked = true;
            } else {
                console.log('user denied the changes...');
            }
        }
    }

    handlePromptClick() {
        lightningPrompt.open({
            message: 'this is the prompt message',
            //theme defaults to "default"
            label: 'Please Respond', // this is the header text
            defaultValue: 'initial input value', //this is optional
        }).then((result) => {
            console.log('Result: '+ result);
            //Prompt has been closed
            //result is input text if OK clicked
            //and null if cancel was clicked
        });
    }
}