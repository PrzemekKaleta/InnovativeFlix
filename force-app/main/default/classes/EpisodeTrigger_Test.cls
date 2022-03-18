@isTest
public with sharing class EpisodeTrigger_Test {

    @isTest
    static void addEpisodtoEmptyDB(){

        Tv_Serie__c tvSerie = TestDataFactory.createTvSerie();
        insert tvSerie;

        Season__c season = TestDataFactory.createSeason(tvSerie.Id, 1);
        insert season;

        Episode__c episode = TestDataFactory.createEpisode(season.Id,1);

        Test.startTest();
        insert episode;
        Test.stopTest();

        List<Episode__c>episodes = [SELECT Id FROM Episode__c];

        System.assertEquals(episodes.size(),1);      


    }

}
