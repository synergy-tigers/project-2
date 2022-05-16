/* 
    Created by Andy Park on 5/14/2022 
	Updated on 5/15/2022 
    Description: This is the controller for RegionAccPage.page.
                 This controller is using SOQL Query and get lists of Accounts by Region
				 in order to show them in page block tables.
*/

public class RegionAccController { 
    public List<Account> westAccounts {get; set;}
    public List<Account> midWestAccounts {get; set;}
    public List<Account> northEastAccounts {get; set;}
    public List<Account> southAccounts {get; set;}
    public List<Account> othersAccounts {get; set;}
    
    public RegionAccController () {
        westAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('AK','AZ','CA','CO','HI',
                  	    'ID','MT','NM','NV','OR','UT','WA','WY') 
                        ORDER BY BillingState ASC];
        midWestAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('IA','IL','IN','KS','MI',
                        'MN','MO','ND','NE','OH','SD','WI')
                        ORDER BY BillingState ASC];
        northEastAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('CT','MA','ME','NH','NJ',
                        'NY','PA','RI','VT')
                        ORDER BY BillingState ASC];
        southAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState IN ('AL','AR','DC','DE','FL',
                        'GA','KY','LA','MD','MS','NC','OK','SC','TN','TX','VA','WV')
                        ORDER BY BillingState ASC];
        othersAccounts = [SELECT BillingState, Name FROM Account
                  WHERE BillingState = null];
    }   
}