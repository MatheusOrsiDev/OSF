public class OpportunityService {

    public static void updateAccountAmountField(List<Opportunity> newList, Map<Id, Opportunity> oldMap){
        
        Set<Id> accountIdsToUpdate = new Set<Id>();
        
        for(Opportunity opp : newList){
            
            if(opp.Amount != oldMap.get(opp.Id).Amount){
                
                accountIdsToUpdate.add(opp.AccountId);
            }
        }
        
        if(!accountIdsToUpdate.IsEmpty()){
            
            List<Opportunity> opportunities = [SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId IN :accountIdsToUpdate];
                
            Map<Id, Decimal> tbdMap = new Map<Id, Decimal>();
                
            for(Opportunity opp : opportunities){
                
                if(tbdMap.containsKey(opp.AccountId)){
                    
                    Decimal currentAmount = tbdMap.get(opp.AccountId);
                    
                    tbdMap.put(opp.AccountId, currentAmount + opp.Amount);
                    
                } else {
                    
                    tbdMap.put(opp.AccountId, opp.Amount);
                }                   
            }
            
            List<Account> accList = new List<Account>();
            
            System.debug(tbdMap);
            
            for (Id key : tbdMap.keySet()) {
                    
                Account newAcc = new Account();
                newAcc.Id = key;
                newAcc.Total_Opportunity_Amount__c = tbdMap.get(key);
                
                accList.add(newAcc);
            }
            
            update accList;
              
      	}
    }

    public static void createTaskWhenOpportunityIsInFirstStage(List<Opportunity> opportunities){

        List<Opportunity> opportuntiesThatAreProspecting = new List<Opportunity>();

        for(Opportunity opps : opportunities){

            if(opps.StageName == 'Prospecting'){

                opportuntiesThatAreProspecting.add(opps);

            }

        }

        if(!opportuntiesThatAreProspecting.isEmpty()){

            List<Task> tasksToBeInserted = new List<Task>();
            Date oneWeekFromToday = Date.today().addDays(7);

            for(Opportunity opps : opportuntiesThatAreProspecting){

                Task newTask = new Task(
                    Subject = 'Call',
                    Priority = 'Normal',
                    Status = 'In Progress',
                    OwnerId = opps.OwnerId,
                    WhatId = opps.Id,
                    ActivityDate = oneWeekFromToday
                    
                );

                tasksToBeInserted.add(newTask);

            }
            insert tasksToBeInserted;
        }

    }
}
