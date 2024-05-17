public class AccountChecker {

    // public static List<Opportunity> getAllOpportunitiesRelatedToAccount(){

    //     List<Account> accounts = [SELECT Id, Name FROM Account];
    //     List<Opportunity> opportunities = [SELECT Id, Account.Name, AccountId FROM Opportunity];

    //     Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);

    //     List<Opportunity> opps = new List<Opportunity>();

    //     for(Opportunity opp : opportunities){

    //         if(accountMap.containsKey(opp.AccountId)){

    //             opps.add(opp);
    //         }
    //     }
    //     return opps;
    // }

    // public static List<Opportunity> getOpportunitiesRelatedToAccount(String accountName){

    //     List<Opportunity> opportunities = [SELECT Id, Name FROM Opportunity WHERE Account.Name = :accountName];

    //     return Opportunities;
    // }

    // public static List<String> getOpportunityNames(List<Opportunity> opportunities){

    //     List<String> opportunityNames = new List<String>();

    //     for(Opportunity opp : opportunities){

    //         opportunityNames.add(opp.Name);
    //     }

    //     return opportunityNames;
    // }

    public static Account getAccountRelatedToContact(String lastName){

        Contact contact = [SELECT Id, Name, AccountId FROM Contact WHERE LastName = :lastName];

        Account account = [SELECT Id, Name FROM Account WHERE Id = :contact.AccountId];

        return account;
    }

    public static List<Opportunity> getOpportunitiesRelatedToAccount(Id accountId){

        List<Opportunity> opportunities = [SELECT Id, Name, Amount FROM Opportunity WHERE AccountId = :accountId];

        //wrote this because i wasnt getting opps back and wanted to see if the list was empty without debugging it.
        if(opportunities.isEmpty()){

            system.debug('No opportunities were found.');
        } 
        return opportunities;
    }

    public static Map<String, Decimal> getOpportunities(List<Opportunity> opportunities){


        Map<String, Decimal> amountByNameMap = new Map<String, Decimal>();

        for(Opportunity opp : opportunities){

            amountByNameMap.put(opp.Name, opp.Amount);

        }
        return amountByNameMap;
    }

    public static List<Opportunity> getAllRelatedOpportunitiesFromMap(Map<String, Decimal> amountByNameMap){

        //List<Opportunity> opportunities = [SELECT Id, Name, Amount FROM Opportunity WHERE Amount IN (0.12, 0.32, 32.23)];
        List<Opportunity> opportunities = [SELECT Id, Name, Amount, Account.Name FROM Opportunity WHERE Name = :amountByNameMap.keySet()];

        return opportunities;


    }

    public static List<String> getConcatenationOfIntegerAndString(List<Integer> integers, List<String> strings){



        if(integers.size() != strings.size()){ return null; }

        // Create a new list to store the concatenation results
        List<String> concatenatedList = new List<String>();

        // Iterate through both lists simultaneously and concatenate
        for (Integer i = 0; i < integers.size(); i++) {
            // Concatenate integer and string and add to the result list
            concatenatedList.add(strings[i] + ' ' + integers[i]);
        }

        return concatenatedList;
    }

    public static List<Integer> getSumOfIntegers(List<Integer> integers1, List<Integer> integers2){

        if(integers1.size() != integers2.size()){
            return null;
        }

        List<Integer> integersSum = new List<Integer>();

        for(Integer i = 0 ; i < integers1.size() ; i++){

            integersSum.add(integers1[i] + integers2[i]);

        }
        return integersSum;
    }

    public static List<Integer> getMultiplierOfIntegers(List<Integer> integers1, Integer integer2){

        if(integers1.isEmpty()){
            return null;
        }

        List<Integer> multiplierOfIntegers = new List<Integer>();

        for(Integer i = 0 ; i < integers1.size() ; i++){

            multiplierOfIntegers.add(integers1[i] * integer2);

        }
        return multiplierOfIntegers;

    }

    public static Map<Integer, String> getStringByIntegerMap(List<Integer> integers, List<String> strings){

        if(integers.size() != strings.size()){
            return null;
        }

        Map<Integer, String> stringByInteger = new Map<Integer, String>();

        for(Integer i = 0 ; i < integers.size() ; i++){

            stringByInteger.put(Integers[i], Strings[i]);

        }
        return stringByInteger;
    }

    public static List<Integer> getSumOfIntegerByInteger(Map<Integer, Integer> integerByIntegerMap1, Map<Integer, Integer> integerByIntegerMap2){

        if(integerByIntegerMap1.size() != integerByIntegerMap2.size()){

            return null;
        }

        List<Integer> sumOfIntegerMaps = new List<Integer>();

        for(Integer i = 0 ; i < integerByIntegerMap1.size() ; i++){

            sumOfIntegerMaps.add(integerByIntegerMap1.values()[i] + integerByIntegerMap2.values()[i]);

        }
        return sumOfIntegerMaps;
    }
}