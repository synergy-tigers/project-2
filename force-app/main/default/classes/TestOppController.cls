/*
    Created By: Kevin Neisser 
    Last Updated: 5/13/2022 
    Description: Testing class for the OppController class.  77% code coverage.  coverage was not 100 because there was no need to test the toggles.
*/
@isTest
public class TestOppController {

    
    
    @testSetup static void createOpportunities(){
        
        //create accounts for opps
        List<Account> accsForTest = Datafactory.generateAccounts(20);
        insert(accsForTest);
        
        //create opps for testing at all stages 
        List<Opportunity> oppsForTest = new List<Opportunity>();
        oppsForTest.add(new Opportunity(Name = 'Oppname0',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Prospecting',
                                       AccountId = accsForTest[0].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname1',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Prospecting',
                                       AccountId = accsForTest[1].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname2',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Qualification',
                                       AccountId = accsForTest[2].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname3',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Qualification',
                                       AccountId = accsForTest[3].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname4',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Needs Analysis',
                                       AccountId = accsForTest[4].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname5',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Needs Analysis',
                                       AccountId = accsForTest[5].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname6',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Value Proposition',
                                       AccountId = accsForTest[6].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname7',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Value Proposition',
                                       AccountId = accsForTest[7].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname8',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Id. Decision Makers',
                                       AccountId = accsForTest[8].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname9',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Id. Decision Makers',
                                       AccountId = accsForTest[9].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname10',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Perception Analysis',
                                       AccountId = accsForTest[10].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname11',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Perception Analysis',
                                       AccountId = accsForTest[11].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname12',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Proposal/Price Quote',
                                       AccountId = accsForTest[12].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname13',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Proposal/Price Quote',
                                       AccountId = accsForTest[13].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname14',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Negotiation/Review',
                                       AccountId = accsForTest[14].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname15',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Negotiation/Review',
                                       AccountId = accsForTest[15].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname16',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Closed Won',
                                       AccountId = accsForTest[16].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname17',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Closed Won',
                                       AccountId = accsForTest[17].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname18',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Closed Lost',
                                       AccountId = accsForTest[18].Id));
        oppsForTest.add(new Opportunity(Name = 'Oppname19',
                                       Product_InterestO__c = 'N665',
                                       CloseDate = Date.newInstance(2022, 06, 01),
                                       StageName = 'Closed Lost',
                                       AccountId = accsForTest[19].Id));
        insert oppsForTest;
    }
    
    //Test for prospect checkbox
    @isTest
    static void prospectCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowProspect = null;
        system.assert(controller.ShowProspect == true);
        Test.stopTest();
    }
    
    //testing Qualification Checkbox
    @isTest
    static void QualCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowQual = null;
        system.assert(controller.ShowQual == true);
        Test.stopTest();
    }
    
    //testing needs analysis checkbox
    @isTest
    static void NeedsCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowNeeds = null;
        system.assert(controller.ShowNeeds == true);
        Test.stopTest();
    }
    
    //testing value proposition checkbox
    @isTest
    static void ValueCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowValue = null;
        system.assert(controller.ShowValue == true);
        Test.stopTest();
    }
    
    //testing ID. Decision Makers checkbox
    @isTest
    static void DecCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowDec = null;
        system.assert(controller.ShowDec == true);
        Test.stopTest();
    }
    
    //testing Perception analysis chechbox
    @isTest
    static void PercCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowPerc = null;
        system.assert(controller.ShowPerc == true);
        Test.stopTest();
    }
    
    //testing proposal/price quote checkbox
    @isTest
    static void PropCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowProp = null;
        system.assert(controller.ShowProp == true);
        Test.stopTest();
    }
    
    //testing negotiation/review checkbox
    @isTest
    static void NegCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowNeg = null;
        system.assert(controller.ShowNeg == true);
        Test.stopTest();
    }
    //testing Closed Won checkbox
    @isTest
    static void CWonCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowCWon = null;
        system.assert(controller.ShowCWon == true);
        Test.stopTest();
    }
    
    //testing closed lost checkbox
    @isTest
    static void CLosCheckboxTP(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.ShowCLos = null;
        system.assert(controller.ShowCLos == true);
        Test.stopTest();
    }
    
    //testing single for prospect 
    @isTest 
    static void prospectTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getProsp();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> prospectingSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Prospecting' AND Name = 'Oppname0'];
        system.assertEquals(1, prospectingSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for prospect 
    @isTest
    static void prospectTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getProsp();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> prospectingBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Prospecting'];
        system.debug(prospectingBulk.size());
        system.assertEquals(2, prospectingBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for Qualification
    @isTest
    static void qualificationTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getQual();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> qualificationSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Qualification' AND Name = 'Oppname2'];
        system.debug(qualificationSingle.size());
        system.assertEquals(1, qualificationSingle.size());
        Test.stopTest(); 
    }
    
    //testing Bulk for Qulaification 
    @isTest
    static void qualificationTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getQual();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> qualificationBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Prospecting'];
        system.debug(qualificationBulk.size());
        system.assertEquals(2, qualificationBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for needs analysis 
    @isTest
    static void needsAnalysisTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getNeeds();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> needsSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Needs Analysis' AND Name = 'Oppname4'];
        system.debug(needsSingle.size());
        system.assertEquals(1, needsSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for needs analysis 
    @isTest
    static void needsAnalysisTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getNeeds();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> needsBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Needs Analysis'];
        system.debug(needsBulk.size());
        system.assertEquals(2, needsBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for value proposition 
    @isTest
    static void valuePropositionTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getValue();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> valueSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Value Proposition' AND Name = 'Oppname6'];
        system.debug(valueSingle.size());
        system.assertEquals(1, valueSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for valur proposition
    @isTest
    static void valuePropositionTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getValue();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> valueBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Value Proposition'];
        system.debug(valueBulk.size());
        system.assertEquals(2, valueBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for Id. decision makers
    @isTest
    static void idDecisionMakersTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getDec();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> decSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Id. Decision Makers' AND Name = 'Oppname8'];
        system.debug(decSingle.size());
        system.assertEquals(1, decSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for Id. decision makers 
    @isTest
    static void idDecisionMakersTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getDec();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> decBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Id. Decision Makers'];
        system.debug(decBulk.size());
        system.assertEquals(2, decBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for perception analysis 
    @isTest
    static void perceptionAnalysisTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getPerc();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> percSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Perception Analysis' AND Name = 'Oppname10'];
        system.debug(percSingle.size());
        system.assertEquals(1, percSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for perception analysis 
    @isTest
    static void perceptionAnalysisTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getPerc();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> percBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Perception Analysis'];
        system.debug(percBulk.size());
        system.assertEquals(2, percBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for proposal/price quote 
    @isTest
    static void proposalTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getProp();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> propSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Proposal/Price Quote' AND Name = 'Oppname12'];
        system.debug(propSingle.size());
        system.assertEquals(1, propSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for proposal/price quote 
    @isTest
    static void proposalTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getProp();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> propBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Proposal/Price Quote'];
        system.debug(propBulk.size());
        system.assertEquals(2, propBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for negotiation/review
    @isTest
    static void negotiationTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getNeg();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> negSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Negotiation/Review' AND Name = 'Oppname14'];
        system.debug(negSingle.size());
        system.assertEquals(1, negSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for negotiation/review
    @isTest
    static void negotiationTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getProp();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> negBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Negotiation/Review'];
        system.debug(negBulk.size());
        system.assertEquals(2, negBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for closed won
    @isTest
    static void closedWonTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getCWon();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> cWSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Closed Won' AND Name = 'Oppname16'];
        system.debug(cWSingle.size());
        system.assertEquals(1, cWSingle.size());
        Test.stopTest(); 
    }
    
    //testing for bulk closed won 
    @isTest
    static void closedWonTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getCWon();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> cWBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Closed Won'];
        system.debug(cWBulk.size());
        system.assertEquals(2, cWBulk.size());
        Test.stopTest(); 
    }
    
    //testing single for closed lost 
    @isTest
    static void closedLostTableSingle(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getCLos();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> cLSingle = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Closed Lost' AND Name = 'Oppname18'];
        system.debug(cLSingle.size());
        system.assertEquals(1, cLSingle.size());
        Test.stopTest(); 
    }
    
    //testing bulk for closed lost 
    @isTest
    static void closedLostTableBulk(){
        Test.startTest();
        pageReference pageRef = page.OpportunityVFPage;
        test.setCurrentPage(pageRef);
        OppController controller = new OppController();
        controller.getCLos();
        List<Account> accsForTest = [SELECT Id, Name FROM Account];
        List<Opportunity> cLBulk = [SELECT Name, Id, Account.Name, Product_InterestO__c, StageName, CloseDate FROM Opportunity WHERE StageName = 'Closed Lost'];
        system.debug(cLBulk.size());
        system.assertEquals(2, cLBulk.size());
        Test.stopTest(); 
    }
}