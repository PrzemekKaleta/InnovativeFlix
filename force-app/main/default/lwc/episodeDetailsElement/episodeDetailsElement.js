import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import EPISODE_DETAIL_KEY_CHANNEL from '@salesforce/messageChannel/Episode_Detail_Key__c';
import getEpisodeById from '@salesforce/apex/EpisodesController.getEpisodeById';

export default class EpisodeDetailsElement extends LightningElement {

    episode;
    subscription = null;

    get createdDate(){
        if(null==this.episode.CreatedDate){
            return "( no date )";
        }else{  
            return this.episode.CreatedDate.slice(0,10);
        }
    }

    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel(){
        this.subscription = subscribe(
            this.messageContext,
            EPISODE_DETAIL_KEY_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }

    refreshPage(){
        refreshApex(this.messageContext);
    }

    handleMessage(message){

        getEpisodeById({episodeId: message.episodeid})
        .then((result)=>{
            this.episode = result;
            this.error = undefined;
        })
        .catch((error)=>{
            this.error = error;
            this.episode = undefined;
        });

    }

    connectedCallback(){
        this.subscribeToMessageChannel();
    }

}