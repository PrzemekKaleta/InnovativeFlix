import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import EPISODE_DETAIL_KEY_CHANNEL from '@salesforce/messageChannel/Episode_Detail_Key__c';

export default class EpisodeDetail extends LightningElement {

    @api episode;

    @wire(MessageContext)
    messageContext;

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

    showDetails(){
            console.log("DETAILS PLEASE");
            publish(this.messageContext, EPISODE_DETAIL_KEY_CHANNEL, {episodeid:this.episode.Id});
    }



}