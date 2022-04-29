public class OrderHandler {
    public static void HandleHealthIns(List<Order> NewOrders){
        Set<Id> ConIds = new Set<Id>();
        Map<Id, Order> ConOrderMap = new Map<Id, Order>(); 
        for (Order currentOrder : NewOrders) {
            if (currentOrder.Product_InterestOrder__c == 'N665'){
                ConIds.add(currentOrder.CustomerAuthorizedById);
                ConOrderMap.put(currentOrder.CustomerAuthorizedById, currentOrder);
//                System.debug('CustomerAuthorizedById: ' + currentOrder.CustomerAuthorizedById);
            }
        }

        List<Policy__c> polWithHealth = [SELECT Policy_Owner1__r.Id FROM Policy__c WHERE ProductP__c = 'N665'];

        Set<Id> contactIdsWH = new Set<Id>();
        for (Policy__c CurrentPolicy : polWithHealth){
//            System.debug('Current Policy object: ' + CurrentPolicy);
//            System.debug('Current Policy owner ID: ' + CurrentPolicy.Policy_Owner1__c);
            contactIdsWH.add(CurrentPolicy.Policy_Owner1__c);
        }

        for (Id CurrConId : ConIds){
            if (contactIdsWH.contains(CurrConId)){
//                System.debug('Flagged contact ID: ' + CurrConId);
                Order flaggedOrder = ConOrderMap.get(CurrConId);
                flaggedOrder.addError('This contact already has health insurance.');
            }
        }
    }
}