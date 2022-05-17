/* 
Created by: Rachel Galang
Description: Tests for CasePlusController
*/

@isTest
public class TestCasePlusController {

    @TestSetup static void setup() {
        List<Case> testCases = new List<Case>();
        List<Contact> testCons = new List<Contact>();
        List<Policy__c> testPols = new List<Policy__c>();
        List<Account> testAccs = new List<Account>();
        for (Integer i = 0; i < 100; i++) {
            testAccs.add(new Account(Name='TestAcc ' + i));
            testCons.add(new Contact(LastName='TestCon ' + i));
        }
        insert testAccs;
        insert testCons;

        for (Integer i = 0; i < 100; i++) {
            testPols.add(new Policy__c(Account__c = testAccs[i].Id,
                                       Policy_Status__c = 'Active',
                                       Policy_Owner_Phone__c = '111-123-1234',
                                       ProductP__c = '19F',
                                       Policy_Quantity__c = 1,
                                       Policy_Cost__C = 1000));
        }
        
        insert testPols;

        for (Integer i = 0; i < 100; i++) {
            List<String> priorities = new List<String>{'Low', 'Medium', 'High'};
            List<String> statuses = new List<String>{'New', 'Working', 'Escalated'};
            testCases.add(new Case(Status=statuses[Integer.valueOf(Math.random() * 3)],
                                    Origin='Web',
                                    Priority= priorities[Integer.valueOf(Math.random() * 3)],
                                    Subject='CasePlusTesting',
                                    AccountId = testAccs[i].Id,
                                    ContactId = testCons[i].Id,
                                    Policy__c = testPols[i].Id));
        }
        insert testCases;
    }

    @isTest static void TestGoToRecordPage() {
        Test.setCurrentPage(Page.CasePlus);
        CasePlusController controller = new CasePlusController();

        Test.setCurrentPageReference(controller.goToRecordPage());

        System.assertEquals(Page.CasePlusDetail.getUrl(), ApexPages.currentPage().getUrl());
        System.assertEquals(null, controller.recordId);
        System.assertEquals(null, controller.recordType);
    }

    @isTest static void TestGoToCasePlusPage() {
        Test.setCurrentPage(Page.CasePlusDetail);
        CasePlusController controller = new CasePlusController();

        Test.setCurrentPageReference(controller.goToCasePlusPage());

        System.assertEquals(Page.CasePlus.getUrl(), ApexPages.currentPage().getUrl());
    }

    @isTest static void TestSortByStatus() {
        CasePlusController controller = new CasePlusController();

        controller.sortSelection = 'statAsc';
        controller.sortCases();
        System.assertEquals('New', controller.filteredCasePlus[0].wrappedCase.Status);
        System.assertEquals('Escalated', controller.filteredCasePlus[99].wrappedCase.Status);

        controller.sortSelection = 'statDesc';
        controller.sortCases();
        System.assertEquals('Escalated', controller.filteredCasePlus[0].wrappedCase.Status);
        System.assertEquals('New', controller.filteredCasePlus[99].wrappedCase.Status);
    }

    @isTest static void TestSortByPriority() {
        //empty priority
        Case testCaseNull = new Case(Status='New', Origin='Web', Subject='CasePlusTesting');
        CasePlusController.CasePlusWrapper nullPriCPW = new CasePlusController.CasePlusWrapper(testCasenull, null, null, null);

        CasePlusController controller = new CasePlusController();

        controller.sortSelection = 'priAsc';
        controller.sortCases();
        System.assertEquals('Low', controller.filteredCasePlus[0].wrappedCase.Priority);
        System.assertEquals('High', controller.filteredCasePlus[99].wrappedCase.Priority);

        controller.sortSelection = 'priDesc';
        controller.sortCases();
        System.assertEquals('High', controller.filteredCasePlus[0].wrappedCase.Priority);
        System.assertEquals('Low', controller.filteredCasePlus[99].wrappedCase.Priority);

        //now testing a null priority
        controller.filteredCasePlus.add(nullPriCPW);
        
        controller.sortSelection = 'priAsc';
        controller.sortCases();
        System.assertEquals(null, controller.filteredCasePlus[0].wrappedCase.Priority);

        controller.sortSelection = 'priDesc';
        controller.sortCases();
        System.assertEquals(null, controller.filteredCasePlus[100].wrappedCase.Priority);
        
    }

    @isTest static void TestToggleExpansion() {
        Test.startTest();
        Test.setCurrentPage(Page.CasePlus);
        CasePlusController controller = new CasePlusController();
        Case testCase = new Case(Status='New', Origin='Web');
        Contact testCon = new Contact(LastName='CasePlus Test Con');
        Account testAcc = new Account(Name='CasePlus Test Acc');
        insert testAcc;
        Policy__c testPol = new Policy__c(Account__c = testAcc.Id,
                                        Policy_Status__c = 'Active',
                                        Policy_Owner_Phone__c = '111-123-1234',
                                        ProductP__c = '19F',
                                        Policy_Quantity__c = 1,
                                        Policy_Cost__C = 1000);


        CasePlusController.CasePlusWrapper testCpw = new CasePlusController.CasePlusWrapper(testCase, testCon, testPol, testAcc);

        //if user hits the same expansion option twice, then it'll just toggle the display off
        //so expansion should equal 'None' after the toggle
        ApexPages.currentPage().getParameters().put('option', 'Policy');
        testCpw.expansion = 'Policy';
        testCpw.toggleExpansion();
        System.assertEquals('None', testCpw.expansion);
        System.assertEquals(false, testCpw.showMore);
        System.assertEquals(false, testCpw.showPolicyInfo);
        System.assertEquals(false, testCpw.showContactInfo);
        System.assertEquals(false, testCpw.showAccountInfo);

        ApexPages.currentPage().getParameters().put('option', 'Policy');
        testCpw.expansion = 'None';
        testCpw.toggleExpansion();
        System.assertEquals('Policy', testCpw.expansion);
        System.assertEquals(true, testCpw.showMore);
        System.assertEquals(true, testCpw.showPolicyInfo);
        System.assertEquals(false, testCpw.showContactInfo);
        System.assertEquals(false, testCpw.showAccountInfo);

        ApexPages.currentPage().getParameters().put('option', 'Contact');
        testCpw.expansion = 'None';
        testCpw.toggleExpansion();
        System.assertEquals('Contact', testCpw.expansion);
        System.assertEquals(true, testCpw.showMore);
        System.assertEquals(false, testCpw.showPolicyInfo);
        System.assertEquals(true, testCpw.showContactInfo);
        System.assertEquals(false, testCpw.showAccountInfo);

        ApexPages.currentPage().getParameters().put('option', 'Account');
        testCpw.expansion = 'None';
        testCpw.toggleExpansion();
        System.assertEquals('Account', testCpw.expansion);
        System.assertEquals(true, testCpw.showMore);
        System.assertEquals(false, testCpw.showPolicyInfo);
        System.assertEquals(false, testCpw.showContactInfo);
        System.assertEquals(true, testCpw.showAccountInfo);
        test.stopTest();
    }

    @isTest static void TestInvalidToggleOption() {
        Test.startTest();
        Test.setCurrentPage(Page.CasePlus);
        CasePlusController controller = new CasePlusController();
        Contact testCon = new Contact(LastName='CasePlus Test Con');
        Account testAcc = new Account(Name='CasePlus Test Acc');
        insert testAcc;
        Policy__c testPol = new Policy__c(Account__c = testAcc.Id,
                                        Policy_Status__c = 'Active',
                                        Policy_Owner_Phone__c = '111-123-1234',
                                        ProductP__c = '19F',
                                        Policy_Quantity__c = 1,
                                        Policy_Cost__C = 1000);
        insert testPol;
        insert testCon;
        Case testCase = new Case(Status='New', Origin='Web', AccountId=testAcc.Id, ContactId=testCon.id, Policy__c = testPol.Id);
        insert testCase;


        CasePlusController.CasePlusWrapper testCpw = new CasePlusController.CasePlusWrapper(testCase, testCon, testPol, testAcc);

        ApexPages.currentPage().getParameters().put('option', 'Invalid');
        testCpw.expansion = 'None';
        testCpw.toggleExpansion();
        System.assertEquals('None', testCpw.expansion);
        System.assertEquals(false, testCpw.showMore);
        System.assertEquals(false, testCpw.showPolicyInfo);
        System.assertEquals(false, testCpw.showContactInfo);
        System.assertEquals(false, testCpw.showAccountInfo);
    }

    @isTest static void TestSortOptions() {
        Test.setCurrentPage(Page.CasePlus);
        CasePlusController controller = new CasePlusController();

        System.assertEquals('', controller.sortOptions[0].getValue());
        System.assertEquals('priAsc', controller.sortOptions[1].getValue());
        System.assertEquals('priDesc', controller.sortOptions[2].getValue());
        System.assertEquals('statAsc', controller.sortOptions[3].getValue());
        System.assertEquals('statDesc', controller.sortOptions[4].getValue());

        System.assertEquals('--NONE--', controller.sortOptions[0].getLabel());
        System.assertEquals('Priority ASC', controller.sortOptions[1].getLabel());
        System.assertEquals('Priority DESC', controller.sortOptions[2].getLabel());
        System.assertEquals('Status ASC', controller.sortOptions[3].getLabel());
        System.assertEquals('Status DESC', controller.sortOptions[4].getLabel());

        System.assertEquals(false, controller.sortOptions[0].getDisabled());
        System.assertEquals(false, controller.sortOptions[1].getDisabled());
        System.assertEquals(false, controller.sortOptions[2].getDisabled());
        System.assertEquals(false, controller.sortOptions[3].getDisabled());
        System.assertEquals(false, controller.sortOptions[4].getDisabled());
    }

    @isTest static void testFiltering() {
        Test.startTest();
        Contact testCon = new Contact(LastName='CasePlusy Test Con');
        Account testAcc = new Account(Name='CasePlusy Test Acc');
        insert testAcc;
        Policy__c testPol = new Policy__c(Account__c = testAcc.Id,
                                        Policy_Status__c = 'Active',
                                        Policy_Owner_Phone__c = '111-123-1234',
                                        ProductP__c = '19F',
                                        Policy_Quantity__c = 1,
                                        Policy_Cost__C = 1000);
        insert testPol;
        insert testCon;
        Case testCase1 = new Case(Status='New', Origin='Web', AccountId=testAcc.Id, ContactId=testCon.id, Policy__c = testPol.Id);
        Case testCase2 = new Case(Status='New', Origin='Web', Priority='Low', Subject='Zoom');
        Case testCase3 = new Case(Status='Working', Origin='Web', Priority='Medium', Subject='Zoom', Description='Blah');
        Case testCase4 = new Case(Status='Escalated', Origin='Web', Priority='High', Subject='Boom');

        CasePlusController.CasePlusWrapper testCpw1 = new CasePlusController.CasePlusWrapper(testCase1, testCon, testPol, testAcc);
        CasePlusController.CasePlusWrapper testCpw2 = new CasePlusController.CasePlusWrapper(testCase2, null, null, null);
        CasePlusController.CasePlusWrapper testCpw3 = new CasePlusController.CasePlusWrapper(testCase3, null, null, null);
        CasePlusController.CasePlusWrapper testCpw4 = new CasePlusController.CasePlusWrapper(testCase4, null, null, null);

        Test.setCurrentPage(Page.CasePlus);
        CasePlusController controller = new CasePlusController();
        controller.filteredCasePlus.add(testCpw1);
        controller.filteredCasePlus.add(testCpw2);
        controller.filteredCasePlus.add(testCpw3);
        controller.filteredCasePlus.add(testCpw4);
        controller.wrappedCasePlus.add(testCpw1);
        controller.wrappedCasePlus.add(testCpw2);
        controller.wrappedCasePlus.add(testCpw3);
        controller.wrappedCasePlus.add(testCpw4);

        //origin is not part of the search string I'm comparing to
        controller.filterText = 'web';
        controller.filterCases();
        System.assertEquals(0, controller.filteredCasePlus.size());
        
        controller.filterText = 'zoom';
        controller.filterCases();
        System.assertEquals(2, controller.filteredCasePlus.size());

        controller.filterText = 'Boom';
        controller.filterCases();
        System.assertEquals(1, controller.filteredCasePlus.size());

        controller.filterText = 'CASEPLUSY';
        controller.filterCases();
        System.assertEquals(1, controller.filteredCasePlus.size());

        controller.filterText = 'blah';
        controller.filterCases();
        System.assertEquals(1, controller.filteredCasePlus.size());
    }

}