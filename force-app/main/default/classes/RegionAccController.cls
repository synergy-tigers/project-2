public class RegionAccController { 
    public List<Account> westAccounts {get; set;}
    public List<Account> midWestAccounts {get; set;}
    public List<Account> northEastAccounts {get; set;}
    public List<Account> southAccounts {get; set;}
    public List<Account> othersAccounts {get; set;}
    
    public Id accId {get; set;}
    
    public RegionAccController ()
    {
        accId = null;
        
        westAccounts = [SELECT Id, Name, BillingState FROM Account
                  WHERE BillingState IN ('AK','AZ','CA','CO','HI',
                  	  'ID','MT','NM','NV','OR','UT','WA','WY')];
        midWestAccounts = [SELECT Id, Name, BillingState FROM Account
                  WHERE BillingState IN ('IA','IL','IN','KS','MI',
                      'MN','MO','ND','NE','OH','SD','WI')];
        northEastAccounts = [SELECT Id, Name, BillingState FROM Account
                  WHERE BillingState IN ('CT','MA','ME','NH','NJ',
                      'NY','PA','RI','VT')];
        southAccounts = [SELECT Id, Name, BillingState FROM Account
                  WHERE BillingState IN ('AL','AR','DC','DE','FL',
                      'GA','KY','LA','MD','MS','NC','OK','SC','TN','TX','VA','WV')];
        othersAccounts = [SELECT Id, Name, BillingState FROM Account
                  WHERE BillingState = null];
    }   
    
    //reference to 2nd page
    public PageReference NextPage() {
        //System.debug('NextPage()'+accId);
        accId = Apexpages.currentpage().getParameters().get('accId');
        //System.debug('NextPage()'+accId);
        return Page.RegionAccPage2;
    }
    
    //reference to 1st page
    public PageReference PrevPage() {
        //System.debug('PrevPage()'+accId);
        return Page.RegionAccPage;
    }    
}