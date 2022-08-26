/* eslint-disable no-console */
import { LightningElement, api, track } from 'lwc';

export default class NewsPanda extends LightningElement {
    
    @track totalResultsFound;
    @track newsData;
    @track searchValue;
    @api success;
    @track page = 1;

    setCriteria(event){
        event.preventDefault();
        console.log(event.target.value);
        this.searchValue = event.target.value;
    }

    searchNewsPanda(){
        fetch('https://newsapi.org/v2/everything?q='+this.searchValue+'&from=2021-01-10&sortBy=publishedAt&apiKey=44a19681fc3c46038baa271692a4ca87')
            .then((response) => {
                console.log('resf '+JSON.stringify(response));
                return response.json();
            })
            .then((myJson) => {
                console.log('my '+JSON.stringify(myJson));
                if(Object.keys(myJson).length !== 0 && myJson.status ==='ok') {
                    this.success = true;
                    this.totalResultsFound = myJson.totalResults;
                    this.newsData = myJson.articles;
                } 
            });
    }

    handleNext() {
        this.page = this.page + 1;
        this.searchNewsPanda();
    }

    handlePrevious() {
        if(this.page > 1){
            this.page = this.page - 1;
            this.searchNewsPanda();
        }
    }
}