public with sharing class CasePlusController {

    public List<Case> AllUserCases {get {
        String userId = UserInfo.getUserId();
        return [SELECT OwnerId, AccountId, ContactId, Policy__c, CreatedDate, Reason, Subject, Description, Priority, Status
                FROM Case WHERE OwnerId = :userId];
    } private set;}

    public List<CasePlusWrapper> wrappedCasePlus {get; set;}
    public List<CasePlusWrapper> filteredCasePlus {get; set;}

    public Boolean expandInfo {get {
        if (expandInfo == null){
            expandInfo = false;
        }
        return expandInfo;
    } set;}

    public CasePlusController() {
        wrappedCasePlus = new List<CasePlusWrapper>();
        filteredCasePlus = new List<CasePlusWrapper>();
        Set<Id> conIds = new Set<Id>();
        Set<Id> polIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        for (Case c : AllUserCases) {
            if (c.ContactId != null) {
                conIds.add(c.ContactId);
            }
            if (c.Policy__c != null) {
                polIds.add(c.Policy__c);
            }
            if (c.AccountId != null) {
                accIds.add(c.AccountId);
            }
        }

        List<Contact> relatedCons = [SELECT FIELDS(STANDARD) FROM Contact WHERE ID in :conIds];
        List<Policy__c> relatedPols = [SELECT Name, Policy_Cost__c, Policy_Quantity__c, Policy_Status__c, ProductP__c FROM Policy__c WHERE ID in :polIds];
        List<Account> relatedAccs = [SELECT Name, Phone, AnnualRevenue FROM Account WHERE ID in :accIds];

        Map<Id,Contact> IdToCon = new Map<Id, Contact>();
        Map<Id,Policy__c> IdToPol = new Map<Id, Policy__c>();
        Map<Id,Account> IdToAcc = new Map<Id, Account>();

        for (Contact con : relatedCons) {
            IdToCon.put(con.Id, con);
        }

        for (Policy__c pol : relatedPols) {
            IdToPol.put(pol.Id, pol);
        }

        for (Account acc : relatedAccs) {
            IdToAcc.put(acc.Id, acc);
        }

        wrappedCasePlus = new List<CasePlusWrapper>();
        for (Case c : AllUserCases) {
            Contact con = null;
            Policy__c pol = null;
            Account acc = null;
            if (c.ContactId != null) {
                con = IdToCon.get(c.ContactId);
            }
            if (c.Policy__c != null) {
                pol = IdToPol.get(c.Policy__c);
            }
            if (c.AccountId != null) {
                acc = IdToAcc.get(c.AccountId);
            }
            CasePlusWrapper newlyWrapped = new CasePlusWrapper(c, con, pol, acc);
            wrappedCasePlus.add(newlyWrapped);
            filteredCasePlus.add(newlyWrapped);
        }
    }


    public class CasePlusWrapper {
        //case and related records
        public Case wrappedCase {get; set;}
        public Contact wrappedContact {get; set;}
        public Policy__c wrappedPolicy {get; set;}
        public Account wrappedAccount {get; set;}

        //variables for controlling the more-info display on each case block
        public String expansion {get; set;}
        public Boolean showMore {get; set;}
        public Boolean showPolicyInfo {get; set;}
        public Boolean showContactInfo {get; set;}
        public Boolean showAccountInfo {get; set;}

        //variables for setting up filters
        Map<String,String> pFilterValues {get; set;}

        public CasePlusWrapper(Case c, Contact con, Policy__c pol, Account acc) {
            wrappedCase = c;
            wrappedContact = con;
            wrappedPolicy = pol;
            wrappedAccount = acc;
            expansion = 'None';
            showMore = false;
        }

        public void toggleExpansion() {
            String option = ApexPages.currentPage().getParameters().get('option');

            if (expansion == option) {
                expansion = 'None';
                showMore = false;
                showPolicyInfo = false;
                showContactInfo = false;
                showAccountInfo = false;
            }
            else {
                expansion = option;
                showMore = true;
                if (option == 'Policy') {
                    showPolicyInfo = true;
                    showContactInfo = false;
                    showAccountInfo = false;
                }
                else if (option == 'Contact') {
                    showPolicyInfo = false;
                    showContactInfo = true;
                    showAccountInfo = false;
                }
                else if (option == 'Account') {
                    showPolicyInfo = false;
                    showContactInfo = false;
                    showAccountInfo = true;
                }
                else {
                    showPolicyInfo = false;
                    showContactInfo = false;
                    showAccountInfo = false;
                    showMore = false;
                }
            }
        }

        // Things I want to filter by...
        // Case: status, priority
        // Contact: name
        // Account: name
        // Policy: number, product
        public void setupPFilters() {
            pFilterValues.put('Case Status', wrappedCase.Status);
            if (wrappedCase.Priority != null) {
                pFilterValues.put('Case Priority', wrappedCase.Priority);
            }
            if (wrappedAccount != null) {
                pFilterValues.put('Account Name', wrappedAccount.Name);
            }
            if (wrappedContact != null) {
                pFilterValues.put('Contact Name', wrappedContact.Name);
            }
            if (wrappedPolicy != null) {
                pFilterValues.put('Policy Number', wrappedPolicy.Name);
                pFilterValues.put('Policy Product', wrappedPolicy.ProductP__c);
            }
        }
    }
}