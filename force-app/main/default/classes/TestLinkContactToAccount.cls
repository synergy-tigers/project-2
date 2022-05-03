/*
Created by: Rachel Galang
Description: Test class for before insert Contact trigger handler 
that checks  to see if a contact has a matching phone number with
any account record and links it to the account if there a match.

When modifying accountID in an Apex trigger, the field is not
actually populated with the correct value until just before
the after trigger events. For this reason, I had to query
for the contact objects I created in order to have access
to the AccountId field with the correct value.
Source: https://help.salesforce.com/s/articleView?id=000335451&type=1
The above refers specifically to cases, but should apply
to Contacts as well.
*/

@isTest
public class TestLinkContactToAccount 
{     
    @TestSetup static void setupAccounts() {
        List<Account> testAccs = new List<Account>();
        List<Id> AcctIds = new List<Id>();
        testAccs.add(new Account(Name='T1', Phone='123-456-7890'));
        testAccs.add(new Account(Name='T2', Phone='111-222-3333'));
        testAccs.add(new Account(Name='T3'));
        insert testAccs;        
    }

    @isTest static void TestContactMatchesAccount() {
        //tests the positive case for single Contact records        

        Test.startTest();
        List<Account> testAccs = [SELECT ID FROM Account WHERE Name IN ('T1', 'T2') ORDER BY Name ASC];
        List<Contact> testCons = new List<Contact>();
        testCons.add(new Contact(LastName='Phone test', Phone='123-456-7890'));
        testCons.add(new Contact(LastName='Home phone test', HomePhone='111-222-3333'));
        
        insert testCons;

        Contact phoneTestContact = [SELECT AccountId FROM Contact WHERE LastName='Phone test' LIMIT 1];
        Contact homePhoneTestContact = [SELECT AccountId FROM Contact WHERE LastName='Home phone test' LIMIT 1];

        //should link to first account because phone matches
        System.assertEquals(testAccs[0].Id,
                            phoneTestContact.AccountId,
                            'Expected contact with matching phone to link to account');

        //should link to second account because home phone matches
        System.assertEquals(testAccs[1].Id, 
                            homePhoneTestContact.AccountId,
                            'Expected contact with matching home phone to link to account');
        Test.stopTest();
    }
    @isTest static void TestContactDoesntMatchAccount() {
        //tests the negative case for a single Contact record
        Test.startTest();

        List<Contact> testCons = new List<Contact>();
        testCons.add(new Contact(LastName='Phone test', Phone='123-555-9906'));
        testCons.add(new Contact(LastName='Home phone test', HomePhone='111-242-3303'));
        testcons.add(new Contact(LastName='No phone test'));

        insert testCons;

        Contact phoneContact = [SELECT AccountId FROM Contact WHERE LastName='Phone test' LIMIT 1];
        Contact homePhoneContact = [SELECT AccountId FROM Contact WHERE LastName='Home phone test' LIMIT 1];
        Contact noPhoneContact = [SELECT AccountId FROM Contact WHERE LastName='No phone test' LIMIT 1];
        
        System.assertEquals(null,
                            phoneContact.AccountId,
                            'Expected contact with non-matching phone to have null account ID');

        System.assertEquals(null,
                            homePhoneContact.AccountId,
                            'Expected contact with non-matching home phone to have null account ID');

        System.assertEquals(null,
                            noPhoneContact.AccountId,
                            'Expected contact with no phone numbers to have null account ID');

        Test.stopTest();
    }

    @isTest static void TestBulkContactsMatchAccounts() {
        //tests the positive case for bulk Contact records
        Test.startTest();

        List<Account> testAccs = [SELECT ID FROM Account WHERE Name IN ('T1', 'T2') ORDER BY Name ASC];
        List<Contact> testPhoneCons = ContactFactory.CreatePhoneContacts(150, '111-222-3333');
        List<Contact> testHomePhoneCons = ContactFactory.createHomePhoneContacts(150, '123-456-7890');

        insert testPhoneCons;
        insert testHomePhoneCons;

        List<Contact> phoneCons = [SELECT AccountId FROM Contact WHERE LastName LIKE 'PTest%'];
        List<Contact> homePhoneCons = [SELECT AccountId FROM Contact WHERE LastName LIKE 'HPTest%'];

        for (Contact curCon : PhoneCons) {
            System.AssertEquals(testAccs[1].Id,
                                curCon.AccountId,
                                'Expected contact with matching phone to link to account');
        }

        for (Contact curCon : HomePhoneCons) {
            System.AssertEquals(testAccs[0].Id,
                                curCon.AccountId,
                                'Expected contact with matching home phone to link to account.');
        }

        Test.stopTest();
    }

    @isTest static void TestBulkContactsDontMatchAccounts() {
        //tests the negative case for bulk Contact records
        Test.startTest();

        List<Contact> testPhoneCons = ContactFactory.CreatePhoneContacts(150, '101-220-333');
        List<Contact> testHomePhoneCons = ContactFactory.createHomePhoneContacts(150, '103-468-7890');
        List<Contact> testNoPhoneCons = ContactFactory.createPhoneContacts(150, null);

        insert testPhoneCons;
        insert testHomePhoneCons;
        insert testNoPhoneCons;
        
        List<Contact> phoneCons = [SELECT AccountId FROM Contact WHERE LastName LIKE 'PTest%'];
        List<Contact> homePhoneCons = [SELECT AccountId FROM Contact WHERE LastName LIKE 'HPTest%'];
        List<Contact> noPhoneCons = [SELECT AccountId from Contact WHERE LastName LIKE 'PTest%'];

        for (Contact curCon : phoneCons) {
            System.AssertEquals(null,
                                curCon.AccountId,
                                'Expected contact with no matching phone to have null AccountId');
        }

        for (Contact curCon : homePhoneCons) {
            System.AssertEquals(null,
                                curCon.AccountId,
                                'Expected contact with no matching home phone to have null AccountId');
        }

        for (Contact curCon : noPhoneCons) {
            System.AssertEquals(null,
                                curCon.AccountId,
                                'Expected contact with no phone numbers to have null AccountId');
        }

        Test.stopTest();        
    }

}
