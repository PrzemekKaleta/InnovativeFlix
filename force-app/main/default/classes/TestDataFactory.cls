public with sharing class TestDataFactory {

    public static Tv_Serie__c createTvSerie(String TvSerieName){
        return new Tv_Serie__c(Name=TvSerieName);
    }
    public static Season__c createSeason(Id tvSerieId, Integer seasonNumber){
        return new Season__c(Tv_Serie__c = tvSerieId, Season_Number__c = seasonNumber);
    }
    public static Episode__c createEpisode(Id seasonId, Integer episodeNumber){
        return new Episode__c(Season__c = seasonId, Episod_Number__c = episodeNumber);
    }
}