public class UpdateRelatedContacts implements Queueable {
    List<Contact> contactsToUpdate;

    public UpdateRelatedContacts(List<Contact> contactsToUpdate) {
        this.contactsToUpdate = contactsToUpdate;
    }

    public void execute(QueueableContext context) {
        try {
            update contactsToUpdate;
        } catch (Exception e) {
            System.debug('Error occurred while updating contacts: ' + e.getMessage());
        }
    }
}
