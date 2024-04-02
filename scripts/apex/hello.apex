String dailySchedule = '0 0 10 * * ?';
System.schedule('Daily Job', dailySchedule, new PrimaryContactEmailBatchSchedule());


String weeklySchedule = '0 0 13 ? * FRI';
System.schedule('Weekly Job', weeklySchedule, new PrimaryContactEmailBatchSchedule());


String monthlySchedule = '0 0 18 ? * 6L';
System.schedule('Monthly Job', monthlySchedule, new PrimaryContactEmailBatchSchedule());
