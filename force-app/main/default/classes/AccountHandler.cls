public with sharing class AccountHandler {
    public static void PreventDeletion(List<Account> Accounts) {
        Set<String> AccountId = new Set<String>();
            for(Account acc: Accounts) {    
                AccountId.add(acc.ID);
            }
        List<Policy__c> policyDet = [SELECT Account__c FROM Policy__c WHERE Account__c IN :AccountId and Policy_Status__c = 'Active'];
    
        //checking policy
        Set<String> PolicyaccId = new Set<String>();
        for (Policy__C policy : policyDet) {
            PolicyaccId.add(policy.Account__c);
        }
    
        for(Account AccDet: Accounts){
            if(PolicyaccId.contains(AccDet.Id)) 
                AccDet.addError('Account has an Active policy');        
        }
    }

    public static void PreventDuplicatePhone(List<Account> Accounts) {
        
    }
}