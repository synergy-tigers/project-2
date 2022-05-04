@isTest
public class TestOrderHandler {

    @TestSetup static void setupOrders() {
        List<Account> AccsForTest = new List<Account>();
        for(Integer i = 0; i < 3; i++){
            Account newAccount = new Account(Name = 'Test' + i);
            AccsForTest.add(newAccount);
        }
            Database.insert(AccsForTest);
        
        List<Contact> ConsForTest = Datafactory.generateContacts(3);

        List<Order> testOrders = new List<Order>();
        List<Id> OrderIds = new List<Id>();
        testOrders.add(new Order(AccountId = AccsForTest[0].Id, 
                                EffectiveDate = Date.newInstance(2022, 06, 01), 
                                Product_InterestOrder__c ='N665', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =500, 
                                Status ='Draft', 
                                CustomerAuthorizedById = ConsForTest[0].Id));
        testOrders.add(new Order(AccountId = AccsForTest[1].Id,  
                                EffectiveDate = Date.newInstance(2022, 06, 02), 
                                Product_InterestOrder__c ='19F', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =500, 
                                Status ='Draft',
                                CustomerAuthorizedById = ConsForTest[1].Id));
        testOrders.add(new Order(AccountId = AccsForTest[2].Id, 
                                EffectiveDate = Date.newInstance(2022, 06, 03), 
                                Product_InterestOrder__c ='N665', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =500, 
                                Status ='Draft',
                                CustomerAuthorizedById = ConsForTest[2].Id));
        insert testOrders;
        
        //stem.DmlException: Insert failed. First exception on row 0; first error: CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY, OrderTrigger: execution of BeforeInsert

//used by: System.ListException: List index out of bounds: 0

//ass.OrderHandler.SetStandardPriceBook: line 59, column 1
//igger.OrderTrigger: line 10, column 1: []

    }
    @isTest static void TestOrderNoPrevPol() {

        Test.startTest();
        //try WHERE des to get all 3?
        List<Order> testOrders = [SELECT AccountId FROM Order WHERE EffectiveDate = THIS_YEAR LIMIT 1];

        Database.SaveResult[] srList = Database.insert(testOrders, false);

        //itterate through if bulk 
        for(Database.SaveResult ord : srList){
            if (ord.isSuccess()) {
                System.debug('successfully inserted Order. Order ID: ' +ord.getId());
            }
            else {
                for(Database.Error err : ord.getErrors()) {
                    System.debug('The following error has occured.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Order Fields that affected this error: ' + err.getFields());
                }
            }
        }
        Test.stopTest();
    }
}