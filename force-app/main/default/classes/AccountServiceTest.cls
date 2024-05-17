@IsTest
public class AccountServiceTest {

    @IsTest
    public static void createCaseForEachContactRelatedToAccountTest(){

        Account acc = new Account(
            Name = 'testAccount',
            NumberOfEmployees = 500
        );

        insert acc;

        Contact con = new Contact(
            LastName = 'testContact',
            AccountId = acc.Id
        );

        insert con;

        acc.NumberOfEmployees = 1600;

        update acc;

        List<Case> cases = [SELECT Id, ContactId FROM Case];

        System.assertEquals(true, !cases.isEmpty(), 'Case list should not be empty.');

    }
}