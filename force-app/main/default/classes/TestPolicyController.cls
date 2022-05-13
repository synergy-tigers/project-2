/*
    Created By: Jonathan Thomas
    Last Updated: 5/13/2022 
    Description: tests for PolicyController
*/

@isTest
public with sharing class TestPolicyController {
    
    //creates test data for use in test class
    @TestSetup 
    static void setupPols(){
        //create accounts for tests
        List<Account> AccsForTest = Datafactory.generateAccounts(3);
        insert(AccsForTest);
        
        //create contacts for tests 
        List<Contact> ConsForTest = Datafactory.generateContacts(3);
        insert ConsForTest;
        
        //create policy for N665 and 19F for 2/3 of the contacts
        List<Policy__c> polsForTest = Datafactory.generatePolicies(AccsForTest[0], ConsForTest[0], 151);
        insert PolsForTest;
        
    }
    
    //tests if the next page is loading
    @isTest
    public static void TP_NextPage(){
        Test.startTest();
       
        Test.setCurrentPage(Page.PoliciesPage);
        PolicyController wiz = new PolicyController();
        
       
        Test.setCurrentPageReference(wiz.NextPage());
        Test.stopTest();
       
        System.assertEquals(Page.PoliciesPage2.getUrl(), ApexPages.currentPage().getUrl());
        System.assertEquals(wiz.filter, null);
        System.assertEquals(wiz.polId , null);

    }
	
    //tests if the previous page loads
    @isTest
    public static void TP_PrevPage(){
        Test.startTest();
        
        Test.setCurrentPage(Page.PoliciesPage2);
        PolicyController wiz = new PolicyController();
        
        Test.setCurrentPageReference(wiz.PrevPage());
        Test.stopTest();
      
       	System.assertEquals(Page.PoliciesPage.getUrl(), ApexPages.currentPage().getUrl());
        System.assertEquals(wiz.filter, null);
        System.assertEquals(wiz.polId , null);
    }
    
    //tests if the filter returns the right amount of objects in the list
    @isTest
    public static void TP_FilterList(){
        Integer listSize = 1;
        Test.setCurrentPage(Page.PoliciesPage);
        PolicyController wiz = new PolicyController();
        
        wiz.filter = wiz.Policies[0].Name.toLowerCase();
        //System.debug('test filter: ' + wiz.filter);
        wiz.FilterList();
        
        System.assertEquals(wiz.filteredList.size(), listSize);
        System.assertEquals(wiz.polId , null);
    }
    
    //tests if no filter is specified then all the policies are shown in the array
    @isTest
    public static void TN_FilterList(){
        Integer listSize = 151;
        Test.setCurrentPage(Page.PoliciesPage);
        PolicyController wiz = new PolicyController();
        
        wiz.filter = '';
        //System.debug('test filter: ' + wiz.filter);
        wiz.FilterList();
        
        System.assertEquals(wiz.filteredList.size(), listSize);
        System.assertEquals(wiz.polId , null);
    }
   
}