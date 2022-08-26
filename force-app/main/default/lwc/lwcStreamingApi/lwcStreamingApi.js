import { LightningElement } from 'lwc';

export default class LwcStreamingApi extends LightningElement {
    
    subscribeMyEvent() {
        console.log(typeof EventSource);
        if (typeof EventSource !== "undefined") {
            console.log('subscribe event...');
            // let eventSource = document.createElement('EventSource');
            // eventSource.appendChild('https://konnectprodstream2.knowlarity.com:8200/update-stream/edda8320-7546-4e53-b880-fbc4dd92cb5e/konnect');
            new MyEvent();
            // console.log('eventSource ' + eventSource);
            // eventSource.onmessage = function (event) {
            //     console.log('event ' + event.data);
            //     this.template.querySelector('.result').innerHTML += event.data + "<br>";
            // };
            // console.log('onmessage ', eventSource.onmessage);
        } else {
            console.log('error ');
            this.template.querySelector(".result").innerHTML = "Sorry, your browser does not support server-sent events...";
        }
    }
}

class MyEvent extends EventSource {
    constructor() {
        super(); 
        this.events = new EventSource("https://konnectprodstream2.knowlarity.com:8200/update-stream/edda8320-7546-4e53-b880-fbc4dd92cb5e/konnect");
        this.events.onopen = (e) => console.log(e);
        this.events.onmessage = (e) => console.log(e);
    }
}