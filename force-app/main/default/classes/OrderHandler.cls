/*
    Created By: Kevin Neisser
    Last Updated: 4/29/2022 
    Description: Prevents the save of an order that has the same product type as an existing policy with the same policy owner
*/

public class OrderHandler {
    
    public static void HandleHealthIns(List<Order> NewOrders){
        Set<Id> ConIds = new Set<Id>();
        Map<Id, Order> ConOrderMap = new Map<Id, Order>(); 
        for (Order currentOrder : NewOrders) {
            if (currentOrder.Product_InterestOrder__c == 'N665'){
                ConIds.add(currentOrder.CustomerAuthorizedById);
                ConOrderMap.put(currentOrder.CustomerAuthorizedById, currentOrder);
                System.debug('CustomerAuthorizedById: ' + currentOrder.CustomerAuthorizedById);
            }
        }

        List<Policy__c> polWithHealth = [SELECT Policy_Owner1__r.Id FROM Policy__c WHERE ProductP__c = 'N665'];
        system.debug(polWithHealth);
        Set<Id> contactIdsWH = new Set<Id>();
        for (Policy__c CurrentPolicy : polWithHealth){
            System.debug('Current Policy object: ' + CurrentPolicy);
            System.debug('Current Policy owner ID: ' + CurrentPolicy.Policy_Owner1__c);
            contactIdsWH.add(CurrentPolicy.Policy_Owner1__c);
        }

        contactIdsWH.remove(null);

        for (Id CurrConId : ConIds){
            if (contactIdsWH.contains(CurrConId)){
                System.debug('Flagged contact ID: ' + CurrConId);
                Order flaggedOrder = ConOrderMap.get(CurrConId);
                flaggedOrder.addError('This contact already has health insurance.');
            }
        }
    }

/*    public static void CheckApprovalStatus(List<Order> newOrders){
        Set<Order> orderSet = new Set<Order>();
        for(Order currOrder: newOrders){
            orderSet.add(currOrder);
        }

        for(Order currOrder : orderSet){
            if (!(Approval.isLocked(currOrder.Id)) && currOrder.Order_Cost__c > 20000){
                if(currOrder.Status != 'Deactivated' && currOrder.Approval_Status__c != null){
                    currOrder.addError('Please send order for approval to change status');
                }
            }
        }
    }

    public static void SetStandardPriceBook(List<Order> newOrder){
        
        List<Pricebook2> standardPriceBookId = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' limit 1];
        for(Order currOrder : newOrder){
            currOrder.Pricebook2Id = standardPriceBookId[0].Id;
        }
    }

    public static void AddProductToOrder(List<Order> modOrders){
        
        List<OrderItem> newItems = new List<OrderItem>();
        for(Order currOrder : modOrders){
            newItems.add(createOrderProduct(currOrder));
        }

        insert newItems;
    }


    //only works if there is a matching product from order
    public static OrderItem createOrderProduct(Order currOrder){
        OrderItem newProd = new OrderItem();

        List<PricebookEntry> prods = [SELECT Product2Id, ProductCode, Id FROM PricebookEntry WHERE Name != null];

        for(Integer i = 0; i < prods.size(); i++){
            if(prods[i].ProductCode == currOrder.Product_InterestOrder__c){
                newProd.Product2Id = prods[i].Product2Id;
                newProd.PricebookEntryId = prods[i].Id;
                newProd.OrderId = currOrder.Id;
                newProd.UnitPrice = currOrder.Order_Cost__c;
                newProd.Quantity = currOrder.Order_Quantity__c;
                break;
            }
        }
        
        return newProd;
    }
*/
}