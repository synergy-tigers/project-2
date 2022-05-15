/*
Created by: Rachel Galang
Description: Test class for before delete Account trigger
that prevents deletion if the account has an active policy attached.
*/

@isTest
public class TestPreventAccountDeletion {
    @isTest static void TestAccountHasActivePolicy() {
        Test.startTest();
        Account testAccount = new Account(Name='HasPolicy');
        insert testAccount;
        Policy__c testPolicy = new Policy__c(Account__c = testAccount.Id,
                                            Policy_Status__c = 'Active',
                                            Policy_Owner_Phone__c = '111-123-1234',
                                            ProductP__c = '19F',
                                            Policy_Quantity__c = 1,
                                            Policy_Cost__C = 1000);
        insert testPolicy;
        
        Database.DeleteResult result;
        try {
            result = Database.delete(testAccount);
        }
        catch (DMLException e) {
            System.assertEquals(true,
                                e.getMessage().contains('Account has an Active policy'),
                                'Expected account with active policy cannot be deleted.');
        }
        Test.stopTest();
    }

    @isTest static void TestAccountInactivePolicy() {
        Test.startTest();
        Account testAccount = new Account(Name='InactivePolicy');
        insert testAccount;
        Policy__c testPolicy = new Policy__c(Account__c = testAccount.Id,
                                            Policy_Status__c = 'Not Active',
                                            Policy_Owner_Phone__c = '111-123-1234',
                                            ProductP__c = '19F',
                                            Policy_Quantity__c = 1,
                                            Policy_Cost__C = 1000);
        insert testPolicy;

        Database.DeleteResult result;

        try {
            result = Database.delete(testAccount);
            System.assertEquals(true, result.isSuccess(), 'Expected account with an inactive policy can be deleted.');
        }
        catch (DmlException e) {
            System.debug(e.getMessage());
        }

        Test.StopTest();
    }

    @isTest static void TestBulkActivePolicies() {
        List<Account> testAccounts = new List<Account>();
        List<Policy__c> testPolicies = new List<Policy__c>();
        Test.startTest();
        for (Integer i = 0; i < 100; i++) {
            Account testAccount = new Account(Name='ActivePolicy ' + i);
            testAccounts.add(testAccount);                                    
        }
        insert testAccounts;

        for (Integer i = 0; i < 100; i++) {
            Policy__c testPolicy = new Policy__c(Account__c = testAccounts[i].Id,
                                                Policy_Status__c = 'Active',
                                                Policy_Owner_Phone__c = '111-123-1234',
                                                ProductP__c = '19F',
                                                Policy_Quantity__c = 1,
                                                Policy_Cost__C = 1000);
            testPolicies.add(testPolicy);
        }
        insert testPolicies;

        List<Database.DeleteResult> results = Database.delete(testAccounts, false);

        for (Database.DeleteResult result : results) {
            System.assertEquals(false, result.isSuccess(), 'Expected account with active policy cannot be deleted.');
        }
        Test.stopTest();
    }

    @isTest static void TestBulkInactivePolicies() {
        List<Account> testAccounts = new List<Account>();
        List<Policy__c> testPolicies = new List<Policy__c>();
        Test.startTest();
        for (Integer i = 0; i < 100; i++) {
            Account testAccount = new Account(Name='ActivePolicy ' + i);
            testAccounts.add(testAccount);                                    
        }
        insert testAccounts;

        //add inactive policies to half the accounts
        for (Integer i = 0; i < 50; i++) {
            Policy__c testPolicy = new Policy__c(Account__c = testAccounts[i].Id,
                                                Policy_Status__c = 'Not Active',
                                                Policy_Owner_Phone__c = '111-123-1234',
                                                ProductP__c = '19F',
                                                Policy_Quantity__c = 1,
                                                Policy_Cost__C = 1000);
            testPolicies.add(testPolicy);
        }
        insert testPolicies;

        List<Database.DeleteResult> results = Database.delete(testAccounts, false);

        for (Database.DeleteResult result : results) {
            System.assertEquals(true, result.isSuccess(), 'Expected account with no policy or inactive policy can be deleted.');
        }
        Test.stopTest();
    }
}