public class OrderHandler {
    public static void HandleHealthIns(List<Order> HealthOrders){
        Set<Id> ConIds = new Set<Id>();
        Map<Id, Order> ConOrderMap = new Map<Id, Order>(); 
        for (Order currentOrder : HealthOrders){
            if (currentOrder.Product_InterestOrder__c == 'N665'){
                ConIds.add(currentOrder.CustomerAuthorizedBy.Id);
                ConOrderMap.put(currentOrder.CustomerAuthorizedBy.Id, currentOrder);
            }
            
        }

        List<Policy__c> polWithHealth = [SELECT Policy_Owner1__r.Id FROM Policy__c WHERE ProductP__c = 'N665'];
        Set<Id> contactIdsWH = new Set<Id>();
        for (Policy__c CurrentPolicy : polWithHealth){
            contactIdsWH.add(CurrentPolicy.Id);
        }
        for (Id CurrConId : ConIds){
            if (contactIdsWH.contains(CurrConId)){
                ConOrderMap.get(CurrConId).addError('This contact already has an N665 product');
            }
        }
    }
}
//get all order contact ids- have this from trigger.new
//for each contact id 
//check that against all policy owner contact ids
// check to make sure it doesnthave n665 as policy type 