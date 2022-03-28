public with sharing class SeasonsController {
    @AuraEnabled(cacheable=true)
    public static List<Season__c> getSeasonsByTvSerie(Id tvSerieId){
        return[
            SELECT Id, Name, Season_Number__c
            FROM Season__c
            WHERE Tv_Serie__c =:tvSerieId
            WITH SECURITY_ENFORCED
            ORDER BY Season_Number__c
        ];
    }
}
