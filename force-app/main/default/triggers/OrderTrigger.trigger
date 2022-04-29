trigger OrderTrigger on Order (before insert) {
    switch on trigger.Operationtype{
        when BEFORE_INSERT{
            OrderHandler.HandleHealthIns(trigger.new);
        }
    }
}