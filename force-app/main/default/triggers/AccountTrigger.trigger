trigger AccountTrigger on Account (after Update, before Insert) {
    if(Trigger.isAfter && (Trigger.isUpdate)){
        AccountService.createCaseForEachContactRelatedToAccount(Trigger.new, Trigger.newMap, Trigger.oldMap);
    }
}