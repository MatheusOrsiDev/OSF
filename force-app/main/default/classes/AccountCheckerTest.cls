@IsTest
public class AccountCheckerTest {
    @IsTest
    public static void getAccountRelatedToContactTest(){

        Account newAccount = new Account();

        newAccount.Name = 'accountTest';

        insert newAccount;


        Contact newContact = new Contact();

        newContact.LastName = 'contactTest';
        newContact.AccountId = newAccount.Id;

        insert newContact;

        Test.startTest();
        Account account = AccountChecker.getAccountRelatedToContact('contactTest');
        Test.stopTest();

        System.assertEquals(newAccount, account, 'Accounts should match!');

    }
    @IsTest
    public static void getOpportunitiesRelatedToAccountTest(){

        Account newAccount = new Account();

        newAccount.Name = 'TestAccount';

        insert newAccount;


        Opportunity newOpp = new Opportunity();

        newOpp.Name = 'TestOpp';
        newOpp.StageName = 'Prospecting';
        newOpp.CloseDate = System.today();
        newOpp.AccountId = newAccount.Id;

        insert newOpp;


        Test.startTest();
        List<Opportunity> opportunities = AccountChecker.getOpportunitiesRelatedToAccount(newAccount.Id);
        Test.stopTest();

        System.assertEquals(true, !opportunities.isEmpty(), 'Opportunity list should not be empty');

    }
    @IsTest
    public static void getOpportunitiesTest(){

        List<Opportunity> opportunities = new List<Opportunity>();

        Opportunity newOpp = new Opportunity();

        newOpp.Name = 'TestOpp';
        newOpp.StageName = 'Prospecting';
        newOpp.CloseDate = System.today();

        opportunities.add(newOpp);

        insert opportunities;

        Test.startTest();
        Map<String, Decimal> mapOpp = AccountChecker.getOpportunities(opportunities);
        Test.stopTest();

        System.assertEquals(true, !mapOpp.isEmpty(), 'Map should not be empty!');

    }

    @IsTest
    public static void getAllRelatedOpportunitiesFromMapTest(){

        List<Opportunity> opportunities = new List<Opportunity>();

        Opportunity newOpp = new Opportunity();

        newOpp.Name = 'testOpp';
        newOpp.Amount = 12.000;
        newOpp.StageName = 'Prospecting';
        newOpp.CloseDate = System.today();

        opportunities.add(newOpp);

        insert opportunities;


        Map<String, Decimal> amountByNameMap = new Map<String, Decimal>();

        for(Opportunity opp : opportunities){

            amountByNameMap.put(opp.Name, opp.Amount);

        }

        Test.startTest();
        List<Opportunity> getOpportunitiesWhereNameIsInMap = AccountChecker.getAllRelatedOpportunitiesFromMap(amountByNameMap);
        Test.stopTest();

        System.assertEquals(true, !getOpportunitiesWhereNameIsInMap.isEmpty(), 'Map should not be empty');
    }

    @IsTest
    public static void combinedTest(){

        List<Opportunity> opportunities = new List<Opportunity>();
        
        Account newAcc = new Account();

        newAcc.Name = 'TestingAcc';

        insert newAcc;

        ///

        Contact newCon = new Contact();

        newCon.LastName = 'TestingCon';
        newCon.AccountId = newAcc.Id;

        insert newCon;

        ///

        Opportunity newOpp = new Opportunity();

        newOpp.Name = 'TestOpp';
        newOpp.Amount = 12.000;
        newOpp.StageName = 'Prospecting';
        newOpp.CloseDate = System.today();
        newOpp.AccountId = newAcc.Id;

        opportunities.add(newOpp);

        insert opportunities;

        ///

        Map<String, Decimal> amountByNameMap = new Map<String, Decimal>();

        for(Opportunity opp : opportunities){

            amountByNameMap.put(opp.Name, opp.Amount);

        }


        AccountChecker.getAccountRelatedToContact('TestingCon');

        AccountChecker.getOpportunitiesRelatedToAccount(newAcc.Id);

        AccountChecker.getOpportunities(opportunities);

        AccountChecker.getAllRelatedOpportunitiesFromMap(amountByNameMap);
        
    }
}