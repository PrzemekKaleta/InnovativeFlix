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

    @AuraEnabled(cacheable=true)
    public static Episode__c getEpisodeById(Id episodeId){
        List<Episode__c> tempList = [
            SELECT Id, Name, Episod_Number__c, Description__c, CreatedDate
            FROM Episode__c
            WHERE Id =:episodeId
            WITH SECURITY_ENFORCED
        ];

        if(tempList.size()==0){
            return null;
        }else{
            return tempList[0];
        }
    }


    @AuraEnabled(cacheable=true)
    public static Integer getNumberOfEpisods(Id seasonId){

        List<Episode__c> tempList = [
            SELECT Id
            FROM Episode__c
            WHERE Season__c =:seasonId
            WITH SECURITY_ENFORCED
        ];

        return tempList.size();

    }
}