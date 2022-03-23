trigger EpisodeTrigger on Episode__c (before insert, before update) {

    System.debug('Triiger RUN');
    EpisodeTriggerHandler.checkEpisodeValidation(Trigger.New);

}