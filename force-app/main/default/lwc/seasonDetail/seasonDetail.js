import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import getEpisodesBySeason from '@salesforce/apex/EpisodesController.getEpisodesBySeason';
import getNumberOfEpisods from '@salesforce/apex/EpisodesController.getNumberOfEpisods';
import TV_SERIE_NAME_FIELD from '@salesforce/schema/Tv_Serie__c.Name';

export default class SeasonDetail extends LightningElement {

    @api season;

    @wire(getRecord, {recordId:'$season.Tv_Serie__c', fields: [TV_SERIE_NAME_FIELD]})
    tvSerie;

    @wire(getNumberOfEpisods,{seasonId: '$season.Id'})
    numberOfEpisodes;
    
    @wire(getEpisodesBySeason,{seasonId: '$season.Id'})
    episodes;

    get name(){
        return getFieldValue(this.tvSerie.data,TV_SERIE_NAME_FIELD);
    }

    get emptyEpisodes(){
        if(this.numberOfEpisodes.data==0){
            return true
        }else{
            return false;
        }       
    }

    openListEpisodes = false;

    clickme(){

        if(this.openListEpisodes){
            this.openListEpisodes = false;

        }else{
            this.openListEpisodes = true;

        }
    }

}