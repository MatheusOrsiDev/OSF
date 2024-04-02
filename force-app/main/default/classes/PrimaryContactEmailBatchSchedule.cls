global class PrimaryContactEmailBatchSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        PrimaryContactEmail_Batch b = new PrimaryContactEmail_Batch();
        database.executebatch(b);
    }
}