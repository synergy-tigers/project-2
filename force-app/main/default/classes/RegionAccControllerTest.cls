/*
    Created by: Andy Park
    Last updated: 5/15/2022
    Description: Test class for RegionAccController 
        that get the SOQL query in order to show Accounts by Region
*/

@isTest
public with sharing class RegionAccControllerTest {
    //Test Setup; prepare the basic Accounts
    //@TestSetup
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
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-WestReion', BillingState = 'CA'));
        Insert testAccounts;

        List<Account> westAccounts = new List<Account>();       
        westAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('AK','AZ','CA','CO','HI',
                  	    'ID','MT','NM','NV','OR','UT','WA','WY') 
                        ORDER BY BillingState ASC];
		System.debug(westAccounts.size());
        System.assertEquals(1, westAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_MidWestRegionAccount() {
        Test.startTest();  
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-MidWestReion', BillingState = 'OH'));
        
        Insert testAccounts;

        List<Account> midWestAccounts = new List<Account>();       
        midWestAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('IA','IL','IN','KS','MI',
                        'MN','MO','ND','NE','OH','SD','WI')
                        ORDER BY BillingState ASC];
		System.debug(midWestAccounts.size());
        System.assertEquals(1, midWestAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_NorthEastRegionAccount() {
        Test.startTest();   
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-NorthEastReion', BillingState = 'NY'));
        Insert testAccounts;

        List<Account> northEastAccounts = new List<Account>();       
        northEastAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('CT','MA','ME','NH','NJ',
                        'NY','PA','RI','VT')
                        ORDER BY BillingState ASC];
		System.debug(northEastAccounts.size());
        System.assertEquals(1, northEastAccounts.size());
        Test.stopTest();
    }    
    
    @isTest
    public static void TP_SouthRegionAccount() {
        Test.startTest(); 
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-SouthReion', BillingState = 'TX'));
        Insert testAccounts;

        List<Account> southAccounts = new List<Account>();       
        southAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('AL','AR','DC','DE','FL',
                        'GA','KY','LA','MD','MS','NC','OK','SC','TN','TX','VA','WV')
                        ORDER BY BillingState ASC];

        System.assertEquals(1, southAccounts.size());
        Test.stopTest();
    }    

     // This tests for negative 
    @isTest
    public static void TP_OthersRegionAccount() {
        Test.startTest();    
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-OthersReion', BillingState = null));
        Insert testAccounts;

        List<Account> othersAccounts = new List<Account>();       
        othersAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState = null];

        System.assertEquals(1, othersAccounts.size());
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

        List<Account> northEastAccounts = new List<Account>();       
        northEastAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('CT','MA','ME','NH','NJ',
                        'NY','PA','RI','VT')
                        ORDER BY BillingState ASC];

        System.assertEquals(152, northEastAccounts.size());
        Test.stopTest();
    }
    
    // This tests for 'Restricted User', run as an administrator.
    @isTest
    public static void TRU_PreventDuplicatePhone() {
        Test.startTest(); 
        User admin = [SELECT name FROM User 
                        WHERE Profile.name = 'System Administrator' LIMIT 1];
        
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test-WestReion', BillingState = 'CA'));
        Insert testAccounts;

        List<Account> westAccounts = new List<Account>();       
        westAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('AK','AZ','CA','CO','HI',
                  	    'ID','MT','NM','NV','OR','UT','WA','WY') 
                        ORDER BY BillingState ASC];

        System.assertEquals(1, westAccounts.size());
        Test.stopTest();
    }
}