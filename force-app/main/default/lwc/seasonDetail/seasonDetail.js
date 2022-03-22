import { LightningElement, api, wire } from 'lwc';
import getEpisodesBySeason from '@salesforce/apex/EpisodesController.getEpisodesBySeason';
export default class SeasonDetail extends LightningElement {

    @api season;

    @wire(getEpisodesBySeason,{seasonId: '$season.Id'})
    episodes;

    //TODO change to false after adding a click event
    openListEpisodes = true;

    clickme(){
        if(this.openListEpisodes){
            this.openListEpisodes = false;
        }else{
            this.openListEpisodes = true;
        }
    }

}