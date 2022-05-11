public class OppController {
    
    //checkbox for Prospects table
    public Boolean ShowProspect {get {
        if (ShowProspect == null) {
            ShowProspect = true;
        }
        return ShowProspect;
    } set;} 

    public void ToggleShowProspect() {
        ShowProspect = ShowProspect;
    }


    //checkbox for qualification
    public Boolean ShowQual {get {
        if (ShowQual == null) {
            ShowQual = true;
        }
        return ShowQual;
    } set;} 

    public void ToggleShowQual() {
        ShowQual = ShowQual;
    }

    //checkbox for Needs Analysis 
    public Boolean ShowNeeds {get {
        if (ShowNeeds == null) {
            ShowNeeds = true;
        }
        return ShowNeeds;
    } set;} 

    public void ToggleShowNeeds() {
        ShowNeeds = ShowNeeds;
    }
    
    //checkbox for value propisition 
    public Boolean ShowValue {get {
        if (ShowValue == null) {
            ShowValue = true;
        }
        return ShowValue;
    } set;} 

    public void ToggleShowValue() {
        ShowValue = ShowValue;
    }

    //checkbox for Id. Decision Makers
    public Boolean ShowDec {get {
        if (ShowDec == null) {
            ShowDec = true;
        }
        return ShowDec;
    } set;} 

    public void ToggleShowDec() {
        ShowDec = ShowDec;
    }

    //checkbox for Perception Analysis
    public Boolean ShowPerc {get {
        if (ShowPerc == null) {
            ShowPerc = true;
        }
        return ShowPerc;
    } set;} 

    public void ToggleShowPerc() {
        ShowPerc = ShowPerc;
    }

    //checkbox for Proposal/Price Quote
    public Boolean ShowProp {get {
        if (ShowProp == null) {
            ShowProp = true;
        }
        return ShowProp;
    } set;} 

    public void ToggleShowProp() {
        ShowProp = ShowProp;
    }

    //checkbox for Negotiation/Review
    public Boolean ShowNeg {get {
        if (ShowNeg == null) {
            ShowNeg = true;
        }
        return ShowNeg;
    } set;} 

    public void ToggleShowNeg() {
        ShowNeg = ShowNeg;
    }
    //checkbox for Closed Won
    public Boolean ShowCWon {get {
        if (ShowCWon == null) {
            ShowCWon = true;
        }
        return ShowCWon;
    } set;} 

    public void ToggleShowCWon() {
        ShowCWon = ShowCWon;
    }
    //checkbox for Close Lost
	public Boolean ShowCLos {get {
        if (ShowCLos == null) {
            ShowCLos = true;
        }
        return ShowCLos;
    } set;} 

    public void ToggleShowCLos() {
        ShowCLos = ShowCLos;
    }

    //list for Prospects 
    public List<Opportunity> getProsp(){
        List<Opportunity> prospects = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Prospecting'];
        return prospects;
    }

    //List for Qualification
    public List<Opportunity> getQual(){
        List<Opportunity> qual = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Qualification'];
        return qual;
    }

    //List for needs analysis
    public List<Opportunity> getNeeds(){
        List<Opportunity> needs = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Needs Analysis'];
        return needs;
    }

    //list for value proposition
    public List<Opportunity> getValue(){
        List<Opportunity> val = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Value Proposition'];
        return val;
    }

    //list for decision makers
    public List<Opportunity> getDec(){
        List<Opportunity> dec = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Id. Decision Makers'];
        return dec;
    }
    
    //list for perception analysis
    public List<Opportunity> getPerc(){
        List<Opportunity> perc = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Perception Analysis'];
        return perc;
    }

    //list for Proposal/Price Quote
    public List<Opportunity> getProp(){
        List<Opportunity> prop = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Proposal/Price Quote'];
        return prop;
    }

    //list for Negotiation/Review
    public List<Opportunity> getNeg(){
        List<Opportunity> neg = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Negotiation/Review'];
        return neg;
    }

    //list for Closed Won
    public List<Opportunity> getCWon(){
        List<Opportunity> won = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
        return won;
    }

    //List for Closed Lost
    public List<Opportunity> getCLos(){
        List<Opportunity> los = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate, Owner.Name FROM Opportunity WHERE StageName = 'Closed Lost'];
        return los;
    }
}