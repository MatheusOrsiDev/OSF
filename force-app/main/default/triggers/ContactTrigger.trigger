trigger ContactTrigger on Contact (after Insert, after Update) {
    // if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
    //     ContactValidatorService.handleContactsPrimaryPhone(Trigger.new);
    // }
}
