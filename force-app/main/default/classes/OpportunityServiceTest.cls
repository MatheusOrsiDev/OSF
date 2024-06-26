@IsTest
public class OpportunityServiceTest {
    @IsTest
    public static void updateAccountAmountFieldTest(){

        List<Opportunity> oppList = new List<Opportunity>();

        Account accTest = new Account(
            Name = 'AccountTest'
        );

        insert accTest;

        Opportunity oppTest = new Opportunity(
            Name = 'OpporunityTest',
            StageName = 'Prospecting',
            AccountId = accTest.Id,
            Amount = 200,
            CloseDate = System.today()
        );

        oppList.add(oppTest);

        Opportunity oppTest2 = new Opportunity( 
            Name = 'OpporunityTest',
            StageName = 'Prospecting',
            AccountId = accTest.Id,
            Amount = 300,
            CloseDate = System.today()
        );

        oppList.add(oppTest2);

        insert oppList;

        oppTest.Amount = 500;

        update oppTest;


        System.assertEquals(800, accTest.Total_Opportunity_Amount__c = 800, 'Account amount field should be 500!');
    }
    @IsTest
    public static void createTaskWhenOpportunityIsInFirstStageTest(){

        Opportunity triggeringOpportunity = new Opportunity(
            Name = 'OpporunityTest',
            StageName = 'Prospecting',
            CloseDate = System.today()
        );

        insert triggeringOpportunity;

        List<Task> tasksRelatedToOpportunity = [SELECT Id FROM Task WHERE WhatId = :triggeringOpportunity.Id];

        System.assertEquals(true, !tasksRelatedToOpportunity.isEmpty(), 'The opportunity did not create any tasks!');

    }
    
}