public class CaseService {
    
    public static void validateIfCaseHasRelatedContact(List<Case> cases){

        for(Case c : cases){

            if(c.ContactId == null){

                c.addError('You must enter a contact before saving!');
            } 
        }

        Set<Id> contactRelatedId = new Set<Id>();
        
        for(Case c : cases){
            
            contactRelatedId.add(c.ContactId);
            
        }
        
        list<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE Id IN :contactRelatedId];
        
        for(Case c : cases){

            for(Contact con : contacts){

                if(con.AccountId == null){
    
                    c.addError('This contact must have a related account before continuing!');
                }
            }
        }   
    }
}










//Everytime a case is created Validate If it has a contact related to It (if not throw an error).
//Then Validate If the contact has an account related to It (If not then throw an error).