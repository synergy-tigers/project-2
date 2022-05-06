@isTest
public class TestOrderHandler {

    @TestSetup static void setupOrders() {
        //create accounts for tests
        List<Account> AccsForTest = new List<Account>();
        for(Integer i = 0; i < 3; i++){
            Account newAccount = new Account(Name = 'Test' + i);
            AccsForTest.add(newAccount);
        }
        Database.insert(AccsForTest);
        //create contacts for tests 
        List<Contact> ConsForTest = Datafactory.generateContacts(3);
        insert ConsForTest;
        
        //create policy for N665 and 19F for 2/3 of the contacts
        List<Policy__c> polsForTest = new List<Policy__c>();
        polsForTest.add(new Policy__c(Account__c = AccsForTest[1].Id,
                                      Policy_Owner1__c = ConsForTest[1].Id,
                                      //Order__c = testOrders[1].Id,
                                      Policy_Owner_Phone__c = ConsForTest[1].Phone,
                                      Policy_Cost__c = 1000,
                                      Policy_Status__c = 'active',
                                      ProductP__c = '19F', 
                                      Policy_Quantity__c = 1));
        polsForTest.add(new Policy__c(Account__c = AccsForTest[2].Id,
                                      Policy_Owner1__c = ConsForTest[2].Id,
                                      //Order__c = testOrders[2].Id,
                                      Policy_Owner_Phone__c = ConsForTest[2].Phone,
                                      Policy_Cost__c = 500,
                                      Policy_Status__c = 'active',
                                      ProductP__c = 'N665', 
                                      Policy_Quantity__c = 1));
        insert polsForTest;
        
        List<Policy__c> testingSQL =[SELECT Policy_Owner1__r.Id FROM Policy__c WHERE ProductP__c = 'N665'];
        system.debug(testingSQL.size());
    }
    
    @isTest static void TestOrderNoPrevPol() {

        Test.startTest();
        //use SOQL to get all neccisary order info that were made in test setup
        List<Account> AccsForTest = [SELECT Id From Account];
        List<Contact> ConsForTest = [SELECT LastName, Phone FROM Contact];
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
        
        //attempt to save the orders created, if 1+2 save and 3 doesn't that is the desired effect
        Database.SaveResult[] srList;
        try { 
            srList = Database.insert(testOrders, false);
        }
        
        catch(Exception e)
            
        {
            
            Boolean expectedExceptionThrown =  e.getMessage().contains('This contact already has health insurance.') ? true : false;
            
            System.AssertEquals(expectedExceptionThrown, true);
            
        } 
        
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
        
        Test.stopTest();
    }
}