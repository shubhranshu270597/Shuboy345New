/* eslint-disable no-console */
import { LightningElement, api } from 'lwc';

export default class VideoPlayer extends LightningElement {
    @api videoURL;

    @api
    get isPlaying(){
        const player = this.template.querySelector('video');
        return player !== null && player.paused === false;
    }

    @api
    play() {
        const player = this.template.querySelector('video');
        console.log('player '+player);
        if (player) {
            player.play();
        }
    }

    @api
    pause() {
        const player = this.template.querySelector('video');
        if (player) {
            player.pause();
        }
    }

    get videoType() {
        return 'video/' + this.videoURL.split('.').pop();
    }

}