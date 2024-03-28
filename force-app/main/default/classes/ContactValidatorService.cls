public class ContactValidatorService {

    public static void handleContactsPrimaryPhone(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact contact : newContacts) {
            accountIds.add(contact.AccountId);
        }

        List<Contact> existingContacts = [SELECT Id, Primary_Contact_Phone__c, Is_Primary_Contact__c, AccountId, LastName FROM Contact WHERE AccountId IN :accountIds];

        List<Contact> conList = new List<Contact>();

        for(Contact triggeringContact : newContacts) {
            if(triggeringContact.Is_Primary_Contact__c) {
                for(Contact existingContact : existingContacts) {
                    if(triggeringContact.AccountId != existingContact.AccountId) {
                        continue;
                    }

                    if(triggeringContact.Id != existingContact.Id && !existingContact.Is_Primary_Contact__c) {
                        existingContact.Primary_Contact_Phone__c = triggeringContact.Primary_Contact_Phone__c;
                        conList.add(existingContact);
                    }
                }
            }
        }

        if(!conList.isEmpty()) {
            System.enqueueJob(new UpdateRelatedContacts(conList));
        }
    }
}