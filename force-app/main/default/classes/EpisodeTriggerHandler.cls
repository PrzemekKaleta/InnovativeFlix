public with sharing class EpisodeTriggerHandler {

    public static void checkEpisodeValidation(List<Episode__c>episodesToCheck){
        
            //new List Id to prepare for Query - get all Id of Seasons that could collide.
            Set<Id>seasonsUsedSet = new Set<Id>();

            for(Episode__c epi : episodesToCheck){
                seasonsUsedSet.add(epi.Season__c);
            }
            
            List<Episode__c>existsEpisodes = new List<Episode__c>();

            if(!seasonsUsedSet.isEmpty()){
                existsEpisodes = [SELECT Id, Season__c,Episod_Number__c FROM Episode__c WHERE Season__c IN:seasonsUsedSet];
            }

            //prepare from exist episodes that can collide where key is Season and value are nuber of episodes
            Map<Id, List<Integer>>mapSeasonsEpisodes = new Map<Id, List<Integer>>();
            
            if(!existsEpisodes.isEmpty()){
                for(Episode__c ep : existsEpisodes){

                    if(mapSeasonsEpisodes.containsKey(ep.Season__c)){

                        mapSeasonsEpisodes.get(ep.Season__c).add(ep.Episod_Number__c.intValue());
                    }else{
                        List<Integer> numbersEpisod = new List<Integer>();
                        numbersEpisod.add(ep.Episod_Number__c.intValue());
                        mapSeasonsEpisodes.put(ep.Season__c,numbersEpisod);
                    }
                }
            }

            //prepare lists to save/unsave and go thru the episodes from Trigger if they (season and number episode) are in map         
            List<Episode__c>listToSave = new List<Episode__c>();
            List<Episode__c>listNotToSave = new List<Episode__c>();

            if(mapSeasonsEpisodes.isEmpty()){
                listToSave.addAll(episodesToCheck);
                
            }else{

                for(Episode__c ep : episodesToCheck){

                    if(mapSeasonsEpisodes.containsKey(ep.Season__c)){
                        List<Integer>listToCheck = mapSeasonsEpisodes.get(ep.Season__c);
                    if(!listToCheck.contains(ep.Episod_Number__c.intValue())){
                            listToSave.add(ep);
                        }else{
                            listNotToSave.add(ep);
                        }              
                    }else{
                        listToSave.add(ep);         
                    }
                }
            }

            //check inside listToSave is there any collision.
            Map<Id, List<Integer>>temMapSeasonsEpisodesToSave = new Map<Id, List<Integer>>();
            
            if(!listToSave.isEmpty()){
                for(Episode__c ep : listToSave){

                    if(temMapSeasonsEpisodesToSave.containsKey(ep.Season__c)){

                        if(temMapSeasonsEpisodesToSave.get(ep.Season__c).contains(ep.Episod_Number__c.intValue())){
                            listNotToSave.add(ep);
                        }else{
                            temMapSeasonsEpisodesToSave.get(ep.Season__c).add(ep.Episod_Number__c.intValue());
                        }
                    }else{
                        List<Integer> numbersEpisod = new List<Integer>();
                        numbersEpisod.add(ep.Episod_Number__c.intValue());
                        temMapSeasonsEpisodesToSave.put(ep.Season__c,numbersEpisod);
                    }
                }
            }

            for(Episode__c ep : listNotToSave){
                ep.addError('For this Season that number of Episode already exist, or you add at least two Episodes with the same number.');
            }


    }

}