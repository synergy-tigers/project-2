public class DataFactory {
    
    public static List<Contact> generateContacts(Integer numContacts){
        List<Contact> ConsForTest = new List<Contact>();
        for (Integer i = 0; i < numContacts; i++){
            Contact newContact = new Contact(LastName = 'TestName' + i, Phone = '1112223333');
            ConsForTest.add(newContact);
        }
        return ConsForTest;
    }
    
    public static List<Account> generateAccounts(Integer numAcc){
        List<Account> AccsForTest = new List<Account>();
        for(Integer i = 0; i < numAcc; i++){
            Account newAccount = new Account(Name = 'Test' + i);
            AccsForTest.add(newAccount);
        }
        return AccsForTest;
    }
    
    public static List<Order> generateOrders(Account acc, Contact con, Integer numOrder){
        List<Order> OrderForTest = new List<Order>();
        
        for(Integer i = 0; i < numOrder; i++){
            Order newOrder = new Order(AccountId = acc.Id, 
                                EffectiveDate = Date.newInstance(2022, 06, 01), 
                                Product_InterestOrder__c ='N665', 
                                Order_Quantity__c =1, 
                                Order_Cost__c =20001, 
                                Status ='Draft', 
                                CustomerAuthorizedById = con.Id);
            
            OrderForTest.add(newOrder);
        }
        
        return OrderForTest;       
    }
}