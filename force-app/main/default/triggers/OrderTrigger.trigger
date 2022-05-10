/*
    Created By: Kevin Neisser & Jonathan Thomas
    Last Updated: 5/10/2022 
    Description: Logicless Triger on order that has a before insert, after insert and before update
*/
trigger OrderTrigger on Order (before insert, before update, after insert) {
    switch on trigger.Operationtype{
        when BEFORE_INSERT{
            OrderHandler.SetStandardPriceBook(trigger.new);
            OrderHandler.HandleHealthIns(trigger.new);
        }
        when BEFORE_UPDATE{
            OrderHandler.CheckApprovalStatus(trigger.new);
        }
        when AFTER_INSERT{
            OrderHandler.AddProductToOrder(trigger.new);
        }
    }
}