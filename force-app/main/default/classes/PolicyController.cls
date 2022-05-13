/*
    Created By: Jonathan Thomas
    Last Updated: 5/13/2022 
    Description: Controller for policy pages
*/

public class PolicyController {
    
    public List<Policy__c> Policies {get; set;}
    public List<Policy__c> filteredList {get; set;}
    public String filter {get; set;}
    public Id polId {get; set;}
    
    //constructor initializes all values 
    public PolicyController() {
        
        filter = null;
        polId = null;
        
        List<Policy__c> allPols = [SELECT Id, Name, Account__r.Name, ProductP__c FROM Policy__c];
        Policies = new List<Policy__c>();
        filteredList = new List<Policy__c>();

        for(Policy__c currPol : allPols){
            Policies.add(currPol);
            filteredList.add(currPol);
        }
    }
    
    //refrence to second page
    public PageReference NextPage() {
        //System.debug('NextPage()' + polId);
        polId = Apexpages.currentpage().getParameters().get('polId');
        //System.debug('NextPage()' + polId);
        return Page.PoliciesPage2;
    }
    
    //refrance to first page
    public PageReference PrevPage() {
        //System.debug('PrevPage()' + polId);
        return Page.PoliciesPage;
    }
    
    //filters the list when html inputtext field is used, changes all shown list
    public void FilterList(){
        filteredList = new List<Policy__c>();
        for(Policy__c currPol : Policies){
            String lowercasePol = currPol.Name.toLowerCase();
            //System.debug(lowercasePol);
            if(lowercasePol.Contains(filter)){ 
                //System.debug('contoller filter: ' + lowercasePol);
                filteredList.add(currPol);
            }
        }
    }
}