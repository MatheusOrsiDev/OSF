trigger OpportunityTrigger on Opportunity (after update, after insert) {
    if(Trigger.IsAfter && Trigger.IsUpdate || Trigger.IsDelete){
        OpportunityService.updateAccountAmountField(Trigger.new, Trigger.oldMap);
    }
}
