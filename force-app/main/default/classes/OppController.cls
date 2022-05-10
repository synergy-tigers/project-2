public class OppController {
    public Boolean ShowProspect {get {
        if (ShowProspect == null) {
            ShowProspect = true;
        }
        return ShowProspect;
    } set;} 

    public void ToggleShowProspect() {
        ShowProspect = ShowProspect;
    }

    public List<Opportunity> getProsp(){
        List<Opportunity> prospects = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Prospecting'];
        return prospects;
    }
    public List<Opportunity> getQual(){
        List<Opportunity> qual = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Qualification'];
        return qual;
    }
    public List<Opportunity> getNeeds(){
        List<Opportunity> needs = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Needs Analysis'];
        return needs;
    }
    public List<Opportunity> getValue(){
        List<Opportunity> val = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Value Proposition'];
        return val;
    }
    public List<Opportunity> getDeci(){
        List<Opportunity> dec = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Id. Decision Makers'];
        return dec;
    }
    public List<Opportunity> getPerc(){
        List<Opportunity> perc = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Perception Analysis'];
        return perc;
    }
    public List<Opportunity> getProp(){
        List<Opportunity> prop = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Proposal/Price Quote'];
        return prop;
    }
    public List<Opportunity> getNeg(){
        List<Opportunity> neg = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Negotiation/Review'];
        return neg;
    }
    public List<Opportunity> getCWon(){
        List<Opportunity> won = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
        return won;
    }
    public List<Opportunity> getCLos(){
        List<Opportunity> los = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Closed Lost'];
        return los;
    }
}