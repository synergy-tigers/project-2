/*
Created by: Rachel Galang
Description: Contact handler class for a Contact trigger that checks
for any account records that match the phone or home phone number of 
the contact(s) about to be inserted and links them if there is a match.
As each Account record represents a household, the phone number of 
the account record is usually a home phone number shared by the people 
within a household (contacts). This is why the LinkToAccount method
only checks the Phone and Home Phone fields of the contact records
as a household is not going to be sharing a mobile phone.
*/

public class ContactHandler {
    public static void LinkToAccount(List<Contact> newContacts) {
        Set<String> contactPhoneNumbers = new Set<String>();
        for (Contact currentContact : newContacts) {
            contactPhoneNumbers.add(currentContact.Phone);
            contactPhoneNumbers.add(currentContact.HomePhone);
        }
        contactPhoneNumbers.remove(null);

        List<Account> AccountsWithMatchingNumber = [SELECT ID, Phone FROM Account 
                                                    WHERE Phone IN :contactPhoneNumbers];
        Map<String, Id> PhonetoAccountMap = new Map<String, Id>();

        for (Account currentAccount : AccountsWithMatchingNumber) {
            PhonetoAccountMap.put(currentAccount.Phone, currentAccount.Id);        
        }
        
        for (Contact currentContact : newContacts) {
            if (PhonetoAccountMap.containsKey(currentContact.Phone)) {
                currentContact.AccountId = PhonetoAccountMap.get(currentContact.Phone);
            }
            else if (PhonetoAccountMap.containsKey(currentContact.HomePhone)) {
                currentContact.AccountId = PhonetoAccountMap.get(currentContact.HomePhone);
            }
        }
    }
}