public with sharing class EpisodesController {
    @AuraEnabled(cacheable=true)
    public static List<Episode__c> getEpisodesBySeason(Id seasonId){
        return[
            SELECT Id, Name, Episod_Number__c, Description__c
            FROM Episode__c
            WHERE Season__c =:seasonId
            WITH SECURITY_ENFORCED
            ORDER BY Episod_Number__c
        ];
    }
}
