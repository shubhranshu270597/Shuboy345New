/*eslint-disable no-console */
import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getLocation from '@salesforce/apex/ZomatoWebService.getLocation';

import { fireEvent } from 'c/pubsub';
import searchResturants from '@salesforce/apex/ZomatoWebService.searchResturants';

export default class Zomato extends LightningElement {
    // location = '';
    // @track entityId;
    // @track selectedLocation;
    // @track entityType;
    // restaurant = '';
    // @track error = '';
    // @track message = '';
    
    location = '';
    entityId = '';
    @track selectedLocation = '';
    entityType = '';
    restaurant = '';

    @wire(CurrentPageReference) pageRef;

    handlelocationChange(event){
        this.location = event.target.value;
        console.log('location', this.location);
    }

    handleRestaurantChange(event){
        this.restaurant = event.target.value;
        console.log('restaurant', this.restaurant);
    }

    selectLocation(){

        getLocation({ 'locationName' : this.location })
        .then(result =>{
            const output = JSON.parse(result);
            this.error = undefined
            console.log("Location::::", output);

            if (output !== undefined) {
                this.entityId = output[0].entity_id;
                this.entityType = output[0].entity_type;
                this.selectedLocation = output[0].title;
                console.log('this.selectedLocation', this.selectedLocation + this.entityId + this.entityType);
                /*this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                );*/
            }
            else {
                console.log("No info returned in call back in selectLocation method");
            }
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            /*this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );*/
            console.log("error", JSON.stringify(this.error));
        });
    }

    searchRestaurant(){
        console.log("restaurant selection data :-->",this.restaurant+' '+this.entityId+' '+this.entityType);
        
        searchResturants({ 'entityId': this.entityId, 'entityType': this.entityType, 'searchTerm' : this.searchTerm })
            .then(result => {
                this.message = JSON.parse(result);
                this.error = undefined
                console.log("Restaurant List::::", this.message);

                if (this.message !== undefined) {
                    console.log("searchRestaurants pubSub fires....");
                    fireEvent(this.pageRef, 'restaurantListUpdate', this.message);
                    /*this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account created',
                            variant: 'success',
                        }),
                    );*/
                }
                else {
                    console.log("No info returned in call back in searchRestaurant method");
                }
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                /*this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );*/
                console.log("error", JSON.stringify(this.error));
            });
    }
}