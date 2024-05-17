List<Account> accounts = [SELECT Id, Name FROM Account];

List<Contact> contacts = [SELECT Id, Account.Name, AccountId FROM Contact];


Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);


Datetime startTime = Datetime.now();

for(Contact con : contacts){

    if(accountMap.containsKey(cons.AccountId)){

        System.debug('Doing something...');
        System.debug('Doing something...');
        System.debug('Doing something...');
    }
}

Datetime endTime = Datetime.now();
System.debug('Total time: ' + (endTime.getTime() - startTime.getTime()));

