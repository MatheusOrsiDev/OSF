public with sharing class AccountControllerExtension {

    public String searchKeyword { get; set; }

    public String contactId { get; set; }

    public List<Contact> contacts { get; set; }

    private ApexPages.StandardController stdController;
    

    public AccountControllerExtension(ApexPages.StandardController stdController) {

        this.stdController = stdController;

    }

    public void search() {

        Account acc = (Account)stdController.getRecord();

        String capturedAccountName = acc.Name;

        List<Contact> contacts = [SELECT Id, Name, Title, Phone, Is_Primary_Contact__c FROM Contact WHERE Account.Name = :capturedAccountName LIMIT 1000];

        this.contacts = contacts;

    }

    public void handlePrimaryContactChange(){

        Account acc = (Account)stdController.getRecord();

        String capturedAccountName = acc.Name;

        List<Contact> contacts = [SELECT Id FROM Contact WHERE Account.Name = :capturedAccountName AND Is_Primary_Contact__c = true];
        
        if(!contacts.isEmpty()){

            for(Contact con : contacts){

                con.Is_Primary_Contact__c = false;

            }
            update contacts;
        }

        Contact con = new Contact();

        con.Id = this.contactId;
        con.Is_Primary_Contact__c = true;

        update con;

        search();
    }
}

