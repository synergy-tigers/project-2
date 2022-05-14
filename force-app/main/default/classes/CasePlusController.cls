/* 
Created by: Rachel Galang
Description: Controller for CasePlus and CasePlusDetail VF pages
*/

public class CasePlusController {

    public List<Case> AllUserCases {get {
        String userId = UserInfo.getUserId();
        return [SELECT OwnerId, AccountId, ContactId, Policy__c, CreatedDate, Reason, Subject, Description, Priority, Status
                FROM Case WHERE OwnerId = :userId];
    } private set;}

    public List<CasePlusWrapper> wrappedCasePlus {get; set;}
    public List<CasePlusWrapper> filteredCasePlus {get; set;}

    public Id recordId {get; set;}
    public String recordType {get; set;}

    public List<SelectOption> sortOptions {get {
        sortOptions = new List<SelectOption>();
        sortOptions.add(new SelectOption('', '--NONE--'));
        sortOptions.add(new SelectOption('priAsc', 'Priority ASC'));
        sortOptions.add(new SelectOption('priDesc', 'Priority DESC'));
        sortOptions.add(new SelectOption('statAsc', 'Status ASC'));
        sortOptions.add(new SelectOption('statDesc', 'Status DESC'));
        return sortOptions;
    } set;}

    public String sortSelection {get {
        return sortSelection;
    } set;}

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

    public void sortCases() {
        switch on sortSelection {
            when 'priAsc' {
                sortByPriority('asc');
            }
            when 'priDesc' {
                sortByPriority('desc');
            }
            when 'statAsc' {
                sortByStatus('asc');
            }
            when 'statDesc' {
                sortByStatus('desc');
            }
        }
    }

    public PageReference goToRecordPage() {
        recordId = ApexPages.currentPage().getParameters().get('recordId');
        recordType = ApexPages.currentPage().getParameters().get('recordType');
        return Page.CasePlusDetail;
    }

    public PageReference goToCasePlusPage() {
        return Page.CasePlus;
    }

    private void sortByPriority(String sortOrder) {
        Map<String, List<CasePlusWrapper>> priorityMap = new Map<String, List<CasePlusWrapper>>();

        List<CasePlusWrapper> tempList = new List<CasePlusWrapper>(filteredCasePlus);
        filteredCasePlus = new List<CasePlusWrapper>();
        List<String> priorityTypes;

        priorityMap.put('null', new List<CasePlusWrapper>());
        priorityMap.put('low', new List<CasePlusWrapper>());
        priorityMap.put('med', new List<CasePlusWrapper>());
        priorityMap.put('high', new List<CasePlusWrapper>());

        for (CasePlusWrapper c : tempList) {
            if (c.wrappedCase.Priority == null) {
                priorityMap.get('null').add(c);
            }
            else if (c.wrappedCase.Priority == 'Low') {
                priorityMap.get('low').add(c);
            }
            else if (c.wrappedCase.Priority == 'Medium') {
                priorityMap.get('med').add(c);
            }
            else if (c.wrappedCase.Priority == 'High') {
                priorityMap.get('high').add(c);
            }
        }

        if (sortOrder == 'asc') {
            priorityTypes = new List<String>{'null', 'low', 'med', 'high'};
        }
        else {
            priorityTypes = new List<String>{'high', 'med', 'low', 'null'};
        }

        for (String priority : priorityTypes) {
            filteredCasePlus.addAll(priorityMap.get(priority));
        }
    }

    private void sortByStatus(String sortOrder) {
        Map<String, List<CasePlusWrapper>> statusMap = new Map<String, List<CasePlusWrapper>>();

        List<CasePlusWrapper> tempList = new List<CasePlusWrapper>(filteredCasePlus);
        filteredCasePlus = new List<CasePlusWrapper>();
        List<String> statusTypes;

        statusMap.put('new', new List<CasePlusWrapper>());
        statusMap.put('work', new List<CasePlusWrapper>());
        statusMap.put('esc', new List<CasePlusWrapper>());

        for (CasePlusWrapper c : tempList) {
            if (c.WrappedCase.Status == 'New') {
                statusMap.get('new').add(c);
            }
            else if (c.WrappedCase.Status == 'Working') {
                statusMap.get('work').add(c);
            }
            else if (c.wrappedCase.Status == 'Escalated') {
                statusMap.get('esc').add(c);
            }
        }

        if (sortOrder == 'asc') {
            statusTypes = new List<String>{'new', 'work', 'esc'};
        }
        else {
            statusTypes = new List<String>{'esc', 'work', 'new'};
        }

        for (String status : statusTypes) {
            filteredCasePlus.addAll(statusMap.get(status));
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
    }
}