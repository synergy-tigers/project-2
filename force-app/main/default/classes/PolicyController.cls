public with sharing class PolicyController {
    
    public String name {get; set;}
    public Integer specialNumber {get; set;}
    public String specialText {get; set;}
    
    public PolicyController() {
        name = null;
        specialNumber = null;
        specialText = null;
    }
    
    public PageReference NextPage() {
        return Page.PoliciesPage2;
    }
    
    public PageReference PrevPage() {
        return Page.PoliciesPage;
    }
    
    public PageReference GoogleMethod() {
        PageReference googlePage = new PageReference('http://www.google.com/search?q=' + name);
        googlePage.setRedirect(true);
        return googlePage;
    }
}