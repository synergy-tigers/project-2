/*
Created by: Rachel Galang
Description: Utility class to set up Account and Contact test data 
for the Contact trigger/ContactHandler tests
*/

@isTest
public class ContactFactory {

    public static List<Contact> createPhoneContacts(Integer numContacts, String phoneNumber) {
        List<Contact> testCons = new List<Contact>();
        for(Integer i = 0; i < numContacts; i++) {
            testCons.add(new Contact(LastName = 'PTest ' + i, Phone = phoneNumber));
        }
        return testCons;
    }

    public static List<Contact> createHomePhoneContacts(Integer numContacts, String phoneNumber) {
        List<Contact> testCons = new List<Contact>();
        for(Integer i = 0; i < numContacts; i++) {
            testCons.add(new Contact(LastName = 'HPTest ' + i, HomePhone = phoneNumber));
        }
        return testCons;
    }
}
