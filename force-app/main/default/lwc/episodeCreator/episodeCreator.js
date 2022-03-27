import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import EPISODE_OBJECT from '@salesforce/schema/Episode__c';
import NUMBER_FIELD from '@salesforce/schema/Episode__c.Episod_Number__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Episode__c.Description__c';
import SEASON_FIELD from '@salesforce/schema/Episode__c.Season__c';

export default class EpisodeCreator extends LightningElement {

        @api season;

        objectApiName = EPISODE_OBJECT;
        seasonId = 'a047Q000001PlTeQAK';
        numberEpisod = NUMBER_FIELD;
        seasonField = SEASON_FIELD;
        description = DESCRIPTION_FIELD;

        handleSuccess(event) {
            const toastEvent = new ShowToastEvent({
                title: "Episode created",
                message: "Episod Number: " + event.detail.Episod_Nuber__c,
                variant: "success"
            });
            this.dispatchEvent(toastEvent);
        }
    
}