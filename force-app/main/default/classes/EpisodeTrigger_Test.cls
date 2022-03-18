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

        System.assertEquals(1,episodes.size());      

    }

    @isTest
    static void addEpisodetoNotEmptyDB(){

        Tv_Serie__c tvSerie1 = TestDataFactory.createTvSerie();
        insert tvSerie1;

        Season__c season1 = TestDataFactory.createSeason(tvSerie1.Id, 1);
        insert season1;

        Episode__c episode1 = TestDataFactory.createEpisode(season1.Id,1); 
        insert episode1;
        
        Tv_Serie__c tvSerie2 = TestDataFactory.createTvSerie2();
        insert tvSerie2;

        Season__c season2 = TestDataFactory.createSeason(tvSerie2.Id, 1);
        insert season2;

        Episode__c episode2 = TestDataFactory.createEpisode(season2.Id,1);
        insert episode2;

        Episode__c episode3 = TestDataFactory.createEpisode(season2.Id,2);
        insert episode3;
        
        Episode__c episode4 = TestDataFactory.createEpisode(season2.Id,3);
        
        Test.startTest();
        insert episode4;
        Test.stopTest();

        List<Episode__c>episodes = [SELECT Id FROM Episode__c];

        System.assertEquals(4,episodes.size());   

    }

    @isTest
    static void addEpisodethatExist(){

        Tv_Serie__c tvSerie = TestDataFactory.createTvSerie();
        insert tvSerie;

        Season__c season = TestDataFactory.createSeason(tvSerie.Id, 1);
        insert season;

        Episode__c episode1 = TestDataFactory.createEpisode(season.Id,1); 
        insert episode1;
        
        Episode__c episode2 = TestDataFactory.createEpisode(season.Id,1);
         
        Test.startTest();
        Database.SaveResult result = Database.insert(episode2, false);
        Test.stopTest();

        List<Episode__c>episodes = [SELECT Id FROM Episode__c];

        System.assertEquals(1,episodes.size());
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);

        for(Database.Error err : result.getErrors()){
            System.assertEquals('For this Season that number of Episode already exist, or you add at least two Episodes with the same number.',err.getMessage());
        }

    }

    @isTest
    static void addDuplicatedEpisodes(){

        Tv_Serie__c tvSerie = TestDataFactory.createTvSerie();
        insert tvSerie;

        Season__c season = TestDataFactory.createSeason(tvSerie.Id, 1);
        insert season;

        Episode__c episode1 = TestDataFactory.createEpisode(season.Id,1);        
        Episode__c episode2 = TestDataFactory.createEpisode(season.Id,1);
        Episode__c episode3 = TestDataFactory.createEpisode(season.Id,2);
         
        List<Episode__c> episodesDuble = new List<Episode__c>();
        episodesDuble.add(episode1);
        episodesDuble.add(episode2);
        episodesDuble.add(episode3);

        Test.startTest();
        Database.SaveResult[] results = Database.insert(episodesDuble, false);
        Test.stopTest();

        List<Episode__c>episodes = [SELECT Id FROM Episode__c];

        System.assertEquals(2,episodes.size());

    }

    @isTest
    static void addListEpisodes(){

        Tv_Serie__c tvSerie = TestDataFactory.createTvSerie();
        insert tvSerie;

        Season__c season = TestDataFactory.createSeason(tvSerie.Id, 1);
        insert season;

        Episode__c episode1 = TestDataFactory.createEpisode(season.Id,1);        
        Episode__c episode2 = TestDataFactory.createEpisode(season.Id,2);
         
        List<Episode__c> episodesDuble = new List<Episode__c>();
        episodesDuble.add(episode1);
        episodesDuble.add(episode2);

        Test.startTest();
        Database.SaveResult[] results = Database.insert(episodesDuble, false);
        Test.stopTest();

        List<Episode__c>episodes = [SELECT Id FROM Episode__c];

        System.assertEquals(2,episodes.size());

    }

}
