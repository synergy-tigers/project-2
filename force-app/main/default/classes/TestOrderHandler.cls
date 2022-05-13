/*
    Created By: Kevin Neisser & Jonathan Thomas
    Last Updated: 5/10/2022 
    Description: Tests all methods in OrderHandeler class 
*/

@isTest
public class TestOrderHandler {

    @TestSetup static void setupOrders() {
        
        //activate standard pricebook
        PriceBook2 standardPriceBook = new PriceBook2(
            Id=Test.getStandardPricebookId(),
        	IsActive=true);
        update standardPriceBook;
        
        // Insert Products
        List<Product2> products = new List<Product2>();
        Product2 insurance = new  Product2();
        insurance.Name='Insurance';
        insurance.ProductCode = '19f';
        insurance.isActive=true;
        products.add(insurance);
        
        Product2 health = new  Product2();
        health.Name='Health';
        health.ProductCode = 'N665';
        health.isActive=true;
        products.add(health);
        
        insert products;
        
        //create price book entries
        Id pricebookId = standardPriceBook.Id;
        System.debug(pricebookId);
        
        List<PricebookEntry> standardPriceEntries = new List<PricebookEntry>();
        
        PricebookEntry standardPriceHealth = new PricebookEntry(
           	Pricebook2Id = pricebookId, Product2Id = Health.Id,
            UnitPrice = 10000, IsActive = true);
        standardPriceEntries.add(standardPriceHealth);
        
        PricebookEntry standardPriceInsurance = new PricebookEntry(
           	Pricebook2Id = pricebookId, Product2Id = Insurance.Id,
            UnitPrice = 10000, IsActive = true);
        standardPriceEntries.add(standardPriceInsurance);
        
        insert standardPriceEntries;
        
        //create accounts for tests
        List<Account> AccsForTest = Datafactory.generateAccounts(3);
        insert(AccsForTest);
        
        //create contacts for tests 
        List<Contact> ConsForTest = Datafactory.generateContacts(3);
        insert ConsForTest;
        
        //create policy for N665 and 19F for 2/3 of the contacts
        List<Policy__c> polsForTest = new List<Policy__c>();
        polsForTest.add(new Policy__c(Account__c = AccsForTest[1].Id,
                                      Policy_Owner1__c = ConsForTest[1].Id,
                                      Policy_Owner_Phone__c = ConsForTest[1].Phone,
                                      Policy_Cost__c = 1000,
                                      Policy_Status__c = 'active',
                                      ProductP__c = '19F', 
                                      Policy_Quantity__c = 1));
        polsForTest.add(new Policy__c(Account__c = AccsForTest[2].Id,
                                      Policy_Owner1__c = ConsForTest[2].Id,
                                      Policy_Owner_Phone__c = ConsForTest[2].Phone,
                                      Policy_Cost__c = 500,
                                      Policy_Status__c = 'active',
                                      ProductP__c = 'N665', 
                                      Policy_Quantity__c = 1));
        insert polsForTest;
        
        List<Policy__c> testingSQL =[SELECT Policy_Owner1__r.Id FROM Policy__c WHERE ProductP__c = 'N665'];
        //System.debug(testingSQL.size());
     
    }
    
    //lists that are used multiple times in the code, used to save SOQL governor  limits
    static final List<Account> AccsForTest = [SELECT Id From Account];
   	static final List<Contact> ConsForTest = [SELECT LastName, Phone FROM Contact];
    static final List<Pricebook2> standardPriceBook = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' limit 1];
    
    @isTest static void TestOrderNoPrevPol() {
        
        //use SOQL to get all neccisary order info that were made in test setup
        List<Policy__c> polsForTest = [SELECT Account__c, 
                                      Policy_Owner1__c,
                                      Policy_Cost__c,
                                      Policy_Status__c,
                                      ProductP__c,
                                      Policy_Quantity__c FROM Policy__c];
        
        List<Order> testOrders = new List<Order>();
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
                                Order_Cost__c =1000, 
                                Status ='Draft',
                                CustomerAuthorizedById = ConsForTest[1].Id));
        testOrders.add(new Order(AccountId = AccsForTest[2].Id, 
                                EffectiveDate = Date.newInstance(2022, 06, 03), 
                                Product_InterestOrder__c ='N665', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =500, 
                                Status ='Draft',
                                CustomerAuthorizedById = ConsForTest[2].Id));
        
        Test.startTest();
        //attempt to save the orders created, if 1+2 save and 3 doesn't that is the desired effect
        Database.SaveResult[] srList;
        try { 
            srList = Database.insert(testOrders, false);
        }
        
        catch(Exception e){
            
            Boolean expectedExceptionThrown =  e.getMessage().contains('This contact already has health insurance.') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);  
        } 
        Test.stopTest();
        
        //itterate through the orders and if they will save or not  
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
    }

    @isTest static void TP_CheckApprovalStatus(){
      
        //create a single order to insert 
        //System.debug(AccsForTest[0].Id);
		Order testOrders = new Order(AccountId = AccsForTest[0].Id, 
                                EffectiveDate = Date.newInstance(2022, 06, 01), 
                                Product_InterestOrder__c ='N665', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =20001, 
                                Status ='Draft', 
                                CustomerAuthorizedById = ConsForTest[0].Id);

        Test.startTest();
        //use try catch block to get error thrown by trigger
        try {
            insert testOrders;
            testOrders.Approval_Status__c = 'Approved';
            update testOrders;
        }
        
        catch(Exception e){
            //use ternary operator to check if the correct error was thrown
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please send order for approval to change status') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);  
        } 

        Test.stopTest();
    }
    

    @isTest static void TB_CheckApprovalStatus(){

        //check for more then 150 bulk dml calls to casue a gov limits error
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 151);
        Test.startTest();

        try {
            insert testOrders;
            for(Integer i = 0; i < testOrders.size(); i++){
           		testOrders[i].Approval_Status__c = 'Rejected';
            }
            update testOrders;
        }
        
        catch(Exception e){
            
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please send order for approval to change status') ? true : false;
            //System.debug('exception thrown: ' + expectedExceptionThrown + ': ' + e.getMessage());
            System.AssertEquals(expectedExceptionThrown, true);  
        } 

        Test.stopTest();
    }
    
    @isTest static void TP_SetStandardPriceBook(){
        
        //uses DataFactory class to make order(s) to insert 
        List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 1);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        //get the added pricebook id from the added orders
        List<Order> insertedOrders = [SELECT Pricebook2Id FROM Order];

        //System.debug('InsertedOrders Size: ' + insertedOrders.size());

        //loop through insertedOrders and check if the inserted Pricebook2Id is the same as the 
        //StandardPriceBook id
        for(Integer i = 0; i < insertedOrders.size(); i++){
            System.AssertEquals(insertedOrders[i].Pricebook2Id, standardPriceBook[0].Id);
        }
    }
	
	@isTest static void TN_SetStandardPriceBook(){       
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 1);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        List<Order> insertedOrders = [SELECT Id, Pricebook2Id FROM Order];

        System.debug('InsertedOrders Size: ' + insertedOrders.size());

        for(INteger i = 0; i < insertedOrders.size(); i++){
            System.assertNotEquals(insertedOrders[i].Pricebook2Id, null);
        }
    }
    
    @isTest static void TB_SetStandardPriceBook(){
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 151);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        List<Order> insertedOrders = [SELECT Id, Pricebook2Id FROM Order];

        System.debug('InsertedOrders Size: ' + insertedOrders.size());

        for(INteger i = 0; i < insertedOrders.size(); i++){
            System.AssertEquals(insertedOrders[i].Pricebook2Id, standardPriceBook[0].Id);
        }
    }
    
    @isTest static void TP_AddProductToOrder(){      
        //create testorders to be inserted and call after insert trigger 
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 1);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        //get prevesoly inserted orders and make a set
        List<Order> insertedOrders = [SELECT Id FROM Order];
        Set<Id> insertedOrderSet = new Set<Id>();
        for(Order currOrder : insertedOrders){
            insertedOrderSet.add(currOrder.Id);
        }
        
        //use set to call a SOQL query that gets orderitem orderids that have insertedorder ids 
        List<OrderItem> orderItem = [SELECT OrderId FROM OrderItem WHERE OrderId IN :insertedOrderSet];

        //if the new orderitem order id matches with the order ids we inserted
        for(Integer i = 0; i < orderItem.size(); i++){
            System.AssertEquals(insertedOrderSet.contains(orderItem[i].OrderId), true);
        }
    }
    
    @isTest static void TN_AddProductToOrder(){       
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 1);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        List<Order> insertedOrders = [SELECT Id FROM Order];
        Set<Id> insertedOrderSet = new Set<Id>();
        for(Order currOrder : insertedOrders){
            insertedOrderSet.add(currOrder.Id);
        }
        
        List<OrderItem> orderItem = [SELECT OrderId FROM OrderItem WHERE OrderId IN :insertedOrderSet];

        for(Integer i = 0; i < orderItem.size(); i++){
            System.assertNotEquals(insertedOrderSet.contains(orderItem[i].OrderId), null);
        }
    }
    
    @isTest static void TB_AddProductToOrder(){       
		List<Order> testOrders = DataFactory.generateOrders(AccsForTest[0], ConsForTest[0], 151);

        Test.startTest();
        insert testOrders;
        Test.stopTest();

        List<Order> insertedOrders = [SELECT Id FROM Order];
        Set<Id> insertedOrderSet = new Set<Id>();
        for(Order currOrder : insertedOrders){
            insertedOrderSet.add(currOrder.Id);
        }
        
        List<OrderItem> orderItem = [SELECT OrderId FROM OrderItem WHERE OrderId IN :insertedOrderSet];

        for(Integer i = 0; i < orderItem.size(); i++){
            System.assertNotEquals(insertedOrderSet.contains(orderItem[i].OrderId), null);
        }
    }
    
}