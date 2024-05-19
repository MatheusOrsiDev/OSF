@IsTest
public class CaseServiceTest {
    @IsTest
    public static void validateIfCaseHasRelatedContactTest1stError(){

        //This case covers the first adderror() scenario if the case doesn't have a contact related.
        Case newCase2 = new Case(
            Subject = 'Validate Employees on account'
            );

        try {
    
            insert newCase2;

        } catch(DmlException e) {

            System.assertEquals(true, e.getMessage().contains('You must enter a contact before saving!'), 'Error Messages are not the same!');
        }

    }
    @IsTest
    public static void validateIfCaseHasRelatedContactTest2ndError(){

        Contact newContact = new Contact(
            LastName = 'testContact'
        );

        insert newContact;

        //This case covers the second adderror() scenario if the case doesn't have a account related.
        Case newCase = new Case(
        ContactId = newContact.Id,
        Subject = 'Validate Employees on account'
        );

        try {

        insert newCase;

        } catch(DmlException e) {

            System.assertEquals(true, e.getMessage().contains('This contact must have a related account before continuing!'), 'Error Messages are not the same!');
        }
    }
}