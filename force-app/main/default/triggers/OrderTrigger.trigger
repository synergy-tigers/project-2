/*
    Created By: Kevin Neisser
    Last Updated: 4/29/2022 
    Description: Prevents the save of an order that has the same product type as an existing policy with the same policy owner
*/
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