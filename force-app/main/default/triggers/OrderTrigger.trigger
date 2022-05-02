trigger OrderTrigger on Order (before insert, before update, after insert) {
    switch on trigger.Operationtype{
        when BEFORE_INSERT{
            OrderHandler.HandleHealthIns(trigger.new);
            OrderHandler.SetStandardPriceBook(trigger.new);
        }
        when BEFORE_UPDATE{
            OrderHandler.CheckApprovalStatus(trigger.new);
        }
        when AFTER_INSERT{
            OrderHandler.AddProductToOrder(trigger.new);
        }
    }
}