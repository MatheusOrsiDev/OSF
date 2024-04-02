public class PrimaryContactEmailService {

    public static void PrimaryContactEmail(List<Contact> contacts){

        Set<Id> accountIds = new Set<Id>();

        List<AggregateResult> aggregate = [SELECT AccountId, StageName, SUM(Amount) FROM Opportunity GROUP BY AccountId, StageName];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Contact con : contacts){

            accountIds.add(con.AccountId);
        }
        
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id = :accountIds];

        Map<Id, Map<String, Object>> accountIdToStageNameMap = new Map<Id, Map<String, Object>>();


        for(Contact c: contacts){

            accountIdToStageNameMap.put(c.AccountId, new map<String, Object>{'Email' => c.Email});

            for(AggregateResult agg : aggregate){

                if(c.AccountId == (Id)agg.get('AccountId')){

                    accountIdToStageNameMap.get(c.AccountId).put((String)agg.get('StageName'), agg.get('expr0')); 
                }
            }
        }

        for(Id accId: accountIdToStageNameMap.keySet()){
         
            String body = '';
            Decimal openTotal = 0;
            String accountName;

            for(Account acc : accounts){

                if(acc.Id == accId){
                    
                    accountName = acc.Name;
                }

            }

            for(String stageName : accountIdToStageNameMap.get(accId).keySet()){

                Object stageValueObject = accountIdToStageNameMap.get(accId).get(stageName);
                
                if(!stageName.equalsIgnoreCase('Closed Won') && !stageName.equalsIgnoreCase('Closed Lost')) {


                    if(stageValueObject instanceof Decimal) {
                        openTotal += (Decimal) stageValueObject;
                    }
                } else {

                    body += '<tr> <td>' + accountName + '</td>' + '<td>' + stageName + '</td>' + '<td>' + stageValueObject + '</td> </tr>';
                }
            }

            if(openTotal > 0) {
                body += '<tr> <td>' + accountName + '</td>' + '<td>' + 'Open' + '</td>' + '<td>' + openTotal + '</td> </tr>';
            }

            List<string> toAddress = new List<string>();
            toAddress.add((String)accountIdToStageNameMap.get(accId).get('Email'));
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(toAddress);

            body = 
                '<table border="1">'+
                    '<thead>'+
                        '<tr>'+
                            '<th>Account Name</th>'+
                            '<th>Stage Name</th>'+
                            '<th>Amount</th>'+
                        '</tr>'+
                    '</thead>'+
                    '<tbody>'+
                        body +
                    '</tbody>'+
                '</table>';

            email.setHtmlBody(body);
            email.setSubject('Opportunity Summary');
            emails.add(email);
            
        }

        if(!emails.isEmpty()){

            system.debug('email count' + emails.size());
            Messaging.sendEmail(emails);
        }
    }
}
    