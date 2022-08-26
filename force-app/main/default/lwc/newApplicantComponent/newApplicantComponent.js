import { LightningElement , track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NewApplicantComponent extends NavigationMixin(LightningElement) {
    @track value = 'None';

    get options() {
        return [
            { label: '---None---', value: 'None' },
            { label: 'Certificate', value: 'Certificate' },
            { label: 'Diploma', value: 'Diploma' },
            { label: 'PGDM', value: 'PGDM' },
            { label: 'Masters', value: 'Masters' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    /*eslint-disable no-console */
    navigateToWebPage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://ngasce.secure.force.com/apex/nmcompleteFormRevised'
            }
        });
    }
}