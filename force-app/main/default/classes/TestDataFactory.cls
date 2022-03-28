public with sharing class TestDataFactory {

    public static Tv_Serie__c createTvSerie(){
        return new Tv_Serie__c(Name='Test Tv Serie 1');
    }
    public static Tv_Serie__c createTvSerie2(){
        return new Tv_Serie__c(Name='Test Tv Serie 2');
    }
    public static Season__c createSeason(Id tvSerieId, Integer seasonNumber){
        return new Season__c(Tv_Serie__c = tvSerieId, Season_Number__c = seasonNumber);
    }
    public static Episode__c createEpisode(Id seasonId, Integer episodNumber){
        return new Episode__c(Season__c = seasonId, Episod_Number__c = episodNumber);
    }
}
