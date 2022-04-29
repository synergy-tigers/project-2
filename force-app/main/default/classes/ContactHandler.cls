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
