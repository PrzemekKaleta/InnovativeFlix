import { LightningElement, api, wire } from 'lwc';
import getSeasonsByTvSerie from '@salesforce/apex/SeasonsController.getSeasonsByTvSerie';
export default class HelloWorld extends LightningElement {
    @api recordId;

    @wire(getSeasonsByTvSerie,{tvSerieId: '$recordId'})
    seasons;

}