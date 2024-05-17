public class AccountService {
    
    public static void createCaseForEachContactRelatedToAccount(List<Account> accounts, Map<Id, Account> newAccountsMap, Map<Id, Account> oldAccountsMap){

        List<Account> accountsThatWillBeUsedForEachContactRelated = new List<Account>();

        for(Account acc : accounts){
            
            if(acc.NumberOfEmployees != oldAccountsMap.get(acc.Id).NumberOfEmployees && newAccountsMap.get(acc.Id).NumberOfEmployees > 1000){

                accountsThatWillBeUsedForEachContactRelated.add(acc);
            }
        }
        
        
        if(!accountsThatWillBeUsedForEachContactRelated.isEmpty()){
            
            List<Contact> cons = [SELECT Id, Name, Contact.AccountId FROM Contact WHERE AccountId IN :accountsThatWillBeUsedForEachContactRelated];
            List<Case> cases = new List<Case>();
    
            for(Contact con : cons){
    
                Case newCase = new Case(
                ContactId = con.Id,
                AccountId = con.AccountId,
                Subject = 'Validate Employees on account'
                );
    
                cases.add(newCase);
            }
            insert cases;
        }
    }
}


// Whenever the Employees field changes and is over 1000 on Account, Create a case for each Contact related to the account.
// The case needs to be linked to the contact and account. The subject of the case should be 'Validate Employees on account".