public class PrimaryContactEmail_Batch implements Database.Batchable<sObject>{
 
    public Database.QueryLocator start(Database.BatchableContext bc){
       return Database.getQueryLocator('SELECT Id, AccountId, Email, Name FROM Contact WHERE Is_Primary_Contact__c = true');
    }
 
    public void execute(Database.BatchableContext bc, List<sObject> scope){
      
        PrimaryContactEmailService.PrimaryContactEmail(scope);

     }
 
    public void finish(Database.BatchableContext bc){
    }
 }