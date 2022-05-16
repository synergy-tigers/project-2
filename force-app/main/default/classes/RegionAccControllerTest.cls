/*
    Created by: Andy Park
    Last updated: 5/15/2022
    Description: Test class for RegionAccController 
        that get the SOQL query in order to show Accounts by Region
*/

@isTest
public with sharing class RegionAccControllerTest {
    //Test Setup; prepare the basic Accounts
    @TestSetup
    public static void setupAccount() {    
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Name1', BillingState = 'CA')); 
        testAccounts.add(new Account(Name = 'Name2', BillingState = 'OH'));
        testAccounts.add(new Account(Name = 'Name3', BillingState = 'NY')); 
        testAccounts.add(new Account(Name = 'Name4', BillingState = 'TX'));
        testAccounts.add(new Account(Name = 'Name5', BillingState = null));
        Insert testAccounts;
    }

    // This tests for positive     
    @isTest
    public static void TP_WestRegionAccount() {
        Test.startTest(); 
        RegionAccController testController = new RegionAccController();
        
        System.debug(testController.westAccounts.size());
        System.assertEquals(1, testController.westAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_MidWestRegionAccount() {
        Test.startTest();  
        RegionAccController testController = new RegionAccController();
        
        System.debug(testController.midWestAccounts.size());
        System.assertEquals(1, testController.midWestAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_NorthEastRegionAccount() {
        Test.startTest();   
        RegionAccController testController = new RegionAccController();

        System.debug(testController.northEastAccounts.size());
        System.assertEquals(1, testController.northEastAccounts.size());
        Test.stopTest();
    }    
    
    @isTest
    public static void TP_SouthRegionAccount() {
        Test.startTest(); 
        RegionAccController testController = new RegionAccController();
        
        System.assertEquals(1, testController.southAccounts.size());
        Test.stopTest();
    }    

     // This tests for negative 
    @isTest
    public static void TP_OthersRegionAccount() {
        Test.startTest();    
        RegionAccController testController = new RegionAccController();
        
        System.assertEquals(1, testController.othersAccounts.size());
        Test.stopTest();
    }    
    
    // This tests for bulk ; 151 Accounts created & tested
    @isTest
    public static void TB_NorthEastAccounts() {         
        Test.startTest();
        //Creating 152 Accounts (BillingState='NY') for testing
        List<Account> testAccounts = new List<Account>();
        for(Integer num = 0; num <152; num++) {
            testAccounts.add(new Account(name = 'Test Account ' + num, BillingState='NY'));
        }
        
        Insert testAccounts;

        RegionAccController testController = new RegionAccController();

        System.assertEquals(153, testController.northEastAccounts.size());
        Test.stopTest();
    }
    
    // This tests for 'Restricted User', run as an administrator.
    @isTest
    public static void TRU_PreventDuplicatePhone() {
        Test.startTest(); 
        User admin = [SELECT name FROM User 
                        WHERE Profile.name = 'System Administrator' LIMIT 1];
        
        RegionAccController testController = new RegionAccController();

        System.assertEquals(1, testController.westAccounts.size());
        Test.stopTest();
    }
}