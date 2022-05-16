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
        RegionAccController controller = new RegionAccController();

		System.debug(controller.westAccounts.size());
        System.assertEquals(1, controller.westAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_MidWestRegionAccount() {
        Test.startTest();  
  		RegionAccController controller = new RegionAccController();
        
		System.debug(controller.midWestAccounts.size());
        System.assertEquals(1, controller.midWestAccounts.size());
        Test.stopTest();
    }    

    @isTest
    public static void TP_NorthEastRegionAccount() {
        Test.startTest();   
		RegionAccController controller = new RegionAccController();

		System.debug(controller.northEastAccounts.size());
        System.assertEquals(1, controller.northEastAccounts.size());
        Test.stopTest();
    }    
    
    @isTest
    public static void TP_SouthRegionAccount() {
        Test.startTest(); 
		RegionAccController controller = new RegionAccController();

        System.assertEquals(1, controller.southAccounts.size());
        Test.stopTest();
    }    

     // This tests for negative 
    @isTest
    public static void TP_OthersRegionAccount() {
        Test.startTest();    
		RegionAccController controller = new RegionAccController();

        System.assertEquals(1, controller.othersAccounts.size());
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

        RegionAccController controller = new RegionAccController();

        System.assertEquals(153, controller.northEastAccounts.size());
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