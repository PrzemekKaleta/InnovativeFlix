import { LightningElement, api } from 'lwc';

export default class EpisodeDetail extends LightningElement {

@api episode;

    get shortDescryption(){

        if(null==this.episode.Description__c){
            return "( no descryption )";
        }else{  
            if(this.episode.Description__c.length<153){
                return this.episode.Description__c
            }else{
                return this.episode.Description__c.slice(0,150) + "...";
            }
        }
    }
}