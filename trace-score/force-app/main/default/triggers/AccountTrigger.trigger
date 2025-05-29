trigger AccountTrigger on Account (after insert,after update) {
    if (Trigger.isAfter && Trigger.isInsert) {
        AccountTriggerHandler.handleAfterInsert(Trigger.new);
    }
    If (Trigger.IsAfter && Trigger.IsUpdate){
        AccountTriggerHandler.updateConDescription (Trigger.new, Trigger.oldMap);
    }
    
    
    
}