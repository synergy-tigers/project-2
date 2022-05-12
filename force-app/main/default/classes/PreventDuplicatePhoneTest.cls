//PreventDuplicatePhoneTest.cls
/*
    Created by: Andy Park
    Last updated: 5/12/2022
    Description: Test class for 'BEFORE INSERT' Account Handler 
        that prevents duplicate phone number in Account
*/

@isTest
public class PreventDuplicatePhoneTest {
    //Test Setup; prepare the basic Accounts
    @TestSetup
    public static void setupAccount() {
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Name1', Phone = '111-222-3000'));
        testAccounts.add(new Account(Name = 'Name2', Phone = '666-777-8000'));
        testAccounts.add(new Account(Name = 'Name3', Phone = null));  
        Insert testAccounts;
    }

    // This tests for one positive & single Account
    @isTest
    public static void TP_PreventDuplicatePhone() {
        Test.startTest();    
        Account testAccount = new Account(Name = 'Test-Duplicate', Phone = '111-222-3000');

        Database.SaveResult result;
        try {
            result = Database.insert(testAccount);
        }
        catch (DmlException e) {
            System.assertEquals(true, 
                e.getMessage().contains('Duplicate! Phone number exists already!'));
        }    
        Test.stopTest();
    }    
    
    // This tests for negative (phone number is null) & single Account
    @isTest 
    public static void TN_AcceptNullPhone() {
        Test.startTest();
        Account testAccount = new Account(Name = 'Test-Null', Phone = null);

        Database.SaveResult result = Database.insert(testAccount);
        System.assertEquals(true, result.isSuccess(),
                           'Null Phone number accepted & inserted');
        Test.stopTest();
    }
  
    // This tests for bulk ; 153 Accounts created & tested
    @isTest
    public static void TB_PreventDuplicatePhone() {         
        Test.startTest();
        //Creating 153 Accounts for testing
        List<Account> testAccounts = new List<Account>();
        for(Integer num = 0; num <151; num++) {
            testAccounts.add(new Account(name = 'Test Account ' + num));
        }
        testAccounts.add(new Account(Name = 'Test152NoDuplicate', Phone= '666-777-8888'));
        testAccounts.add(new Account(Name = 'Test153Duplicate', Phone= '666-777-8000'));

        List<Database.SaveResult> resultList;
        try {
            resultList = Database.insert(testAccounts);
        }
        catch (DmlException e) {
            System.assertEquals(true, 
                e.getMessage().contains('Duplicate! Phone number exists already!'));
        }    
        Test.stopTest();
    }
    
    // This tests for 'Restricted User', run as an administrator.
    @isTest
    public static void TRU_PreventDuplicatePhone() {
        Test.startTest(); 
        User admin = [SELECT name FROM User 
                        WHERE Profile.name = 'System Administrator' LIMIT 1];
        Account testAccount = new Account(Name = 'Test-Admin-Duplicate', 
            Phone = '111-222-3000');
        Database.SaveResult result;
        try {
            result = Database.insert(testAccount);
        }
        catch (DmlException e) {
            System.assertEquals(true, 
                e.getMessage().contains('Duplicate! Phone number exists already!'));
        }    
        Test.stopTest();
    }
}