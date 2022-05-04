trigger insuraAccountTrigger on Account (before delete, before insert) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            AccountHandler.PreventDuplicatePhone(Trigger.new);
        }
        when BEFORE_DELETE {
            AccountHandler.PreventDeletion(Trigger.old);
        }    
    }        
}