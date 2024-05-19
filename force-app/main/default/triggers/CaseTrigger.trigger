trigger CaseTrigger on Case (after insert, before insert) {

    if(Trigger.isBefore && (Trigger.isInsert)){

        CaseService.validateIfCaseHasRelatedContact(Trigger.new);

    }

}









//Everytime a case is created Validate If it has a contact related to It (if not throw an error).
//Then Validate If the contact has an account related to It (If not then throw an error).