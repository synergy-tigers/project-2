public class DataFactory {
    public static List<Contact> generateContacts(Integer numContacts){
        List<Contact> ConsForTest = new List<Contact>();
        for (Integer i = 0; i < numContacts; i++){
            Contact newContact = new Contact(LastName = 'TestName' + i);
            ConsForTest.add(newContact);
        }
        return ConsForTest;
    }
    public static List<Policy__c> generatePolicies(Integer numPol){
         
        
     return null;       
    }
    public static List<Account> generateAccounts(Integer numAcc){
         List<Account> AccsForTest = new List<Account>();
        for(Integer i = 0; i < numAcc; i++){
            Account newAccount = new Account(Name = 'Test' + i);
            AccsForTest.add(newAccount);
        }
            return AccsForTest;
    
    
    }
}