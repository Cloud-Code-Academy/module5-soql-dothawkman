/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Sean Hawkins
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads () {

        List<Lead> allLeads = [
            SELECT Id, LastName, Company, Phone, Email 
            FROM Lead];
        
        return allLeads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName () {

        List<Contact> allContacts = [
            SELECT Id, FirstName, LastName, Account.Name, Phone, Email, Name
            FROM Contact
            WHERE FirstName = 'John'];
        
        return allContacts;
   }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName () {
    
            List<Id> contactIds = new List<Id>();
            for (Contact cont : [
                SELECT Id, LastName
                FROM Contact
                WHERE LastName IN ('Smith', 'Jones')]) {
            contactIds.add(cont.Id);
         } 
         return contactIds;
    }
    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (id accountId) {
    
            List<Opportunity>  cwOpps = [
                SELECT Id, AccountId, Name, StageName, CloseDate, Amount 
                FROM Opportunity 
                WHERE Accountid = :accountid AND StageName = 'Closed Won'];

            return cwOpps;

    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static integer getAccountCount () {

            Integer accCount = [
                SELECT Count() 
                FROM Account];
            return accCount;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id,Task> getTasksDueNextWeek () {

            Map<Id,Task> tasksDueNextWeek = new Map<Id,Task>([
                SELECT Id, Subject, ActivityDate 
                FROM Task 
                WHERE ActivityDate = NEXT_N_DAYS:7]);
            return tasksDueNextWeek;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {

            List<Contact> contactsByEmailDomain = [
                SELECT Id, Name, Email 
                FROM Contact 
                WHERE Email LIKE '%example.com'];

            return contactsByEmailDomain;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {

        List<Opportunity> opportunitiesByNameKeyword = [
            SELECT Id, Name, StageName, CloseDate, Amount 
            FROM Opportunity 
            WHERE Name LIKE :'%'+keyword+'%'];
    
        return opportunitiesByNameKeyword; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {

        List<Case> filterCaseOrigins = [
            SELECT Id, CaseNumber, Origin 
            FROM Case 
            WHERE Origin NOT IN ('Web', 'Email', '')];
        
        return filterCaseOrigins; // Replace null with the variable you used to store the result
   
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getGetLeadsBySourceOrTitl(string keyword, string leadsource) {
        
        List<Lead> leads = [
            SELECT Id, Leadsource, Title, Company, Phone, Email 
            FROM LEAD 
            WHERE Leadsource = :leadsource OR Title LIKE :'%'+keyword+'%'];

        return leads;
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
    
        List<String> contactLastNames = new List<String>();
        for (contact con:[
            SELECT Id, FirstName, LastName 
            FROM Contact 
            WHERE AccountId = :accountId]) {
            contactLastNames.add(con.LastName);
        }

        return contactLastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {

        List<Aggregateresult> totalRevList = [
            SELECT SUM(Amount) 
            FROM Opportunity 
            WHERE StageName = :stage
            OR Amount > 10000];
    
            String str = string.valueOf(totalRevList[0].get('expr0'));
            Decimal totalRevenue = Decimal.valueOf(str);
        
        return totalRevenue; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {

        List<Account> firstTenAccounts = [
            SELECT Id, Name, Phone, Industry 
            FROM Account 
            ORDER BY Name 
            LIMIT 10];
        return firstTenAccounts; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {

        List<Opportunity> highValueOpportunities = [
            SELECT Id, Name, CloseDate, Amount 
            FROM Opportunity 
            WHERE Amount > 100000 
            ORDER BY CloseDate 
            LIMIT 5];
        return highValueOpportunities; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {

        List<Contact> birthdateContacts = [
            SELECT Id, Name, Birthdate 
            FROM Contact 
            ORDER BY Birthdate DESC 
            LIMIT 3];
        return birthdateContacts; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> casesWithStatus = [
            SELECT Id, Status, CreatedDate 
            FROM Case 
            WHERE Status = 'Open' 
            ORDER BY CreatedDate
            LIMIT 10 OFFSET 5];
        return casesWithStatus; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();
        for (case c:[
            SELECT Id, Subject, Status, Accountid
            FROM Case 
            WHERE AccountId = :accountId]) {
            caseIds.add(c.Id);
        }
        return caseIds; // Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
       
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        for (account a:[
            SELECT Id, Name, BillingCountry
            FROM Account
            WHERE BillingCountry != :country]) {
            accountIdsToNames.put(a.Id, a.Name);
        }
        return accountIdsToNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {

        Contact contact = [
            SELECT Id, Account.Name
            FROM Contact 
            WHERE Id = :contactId];
        return contact.Account.Name; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {

        Account account = [
            SELECT Id, Name,
                (SELECT Id, Name FROM Opportunities)
            FROM Account 
            WHERE Id = :accountId];
        return account; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account myAccount = [
            SELECT Name, BillingState 
            FROM Account 
            WHERE Id = :accountId];

        // Store the Account's BillingState
        String accountBillingState = myAccount.BillingState;

        // Query the Contacts
        List<Contact> myContacts = [
            SELECT Id, Name, MailingState 
            FROM Contact 
            WHERE MailingState LIKE :accountBillingState];

        return myContacts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        // Create a set of email domains from the Leads
        // Loop through each Lead
        // Get the email from the Lead
        // Check if the email is not null
        // Add the email domain to the set
        // Query the Accounts

        List<Lead> leads = [
            SELECT Id, Email 
            FROM Lead 
            WHERE Id IN :leadIds];
 
        set<String> emailDomains = new set<String>();
        for (lead l:leads) {
            emailDomains.add('www.' + l.Email.split('@').get(1));
        }
        
        List<Account> accounts = [
            SELECT Id, Name, Website 
            FROM Account 
            WHERE website LIKE :emailDomains];
        
        return accounts;
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> olis = [
            SELECT Id, OpportunityId, Quantity, PricebookEntryId, UnitPrice
            FROM OpportunityLineItem 
            WHERE OpportunityId = :origOppId];


        // Create a list to hold the new line items
        List<OpportunityLineItem> linelist = new List<OpportunityLineItem>();


        // Generate a random number between 1 and 3
        Integer randomQuantity = Integer.valueof((Math.random() * 3));

        // Loop through each cloned Opportunity Id
        for (Id cloneOppId : cloneOppIds) {
            for (OpportunityLineItem oli : olis) {
                OpportunityLineItem newOLI = oli.clone();
                newOLI.OpportunityId = cloneOppId;
                newOLI.Quantity = oli.Quantity + randomQuantity;
                newOLI.PricebookEntryId = oli.PricebookEntryId;
                newOLI.UnitPrice = oli.UnitPrice;
                linelist.add(newOLI);
            }
        }

        insert linelist;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        List<Opportunity> opportunites = [
            SELECT id, Name, Account.id, Owner.id
            FROM Opportunity
            WHERE StageName = 'Closed Won'];

        return opportunites; 
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> opportunites = [
            SELECT id, Name, Account.id, Owner.id, StageName, Primary_Contact__c 
            FROM Opportunity
            WHERE StageName = 'Closed Won'];

        Set<Id> acctIds = new Set<Id>();
        for (Opportunity o : opportunites) {
            acctIds.add(o.Account.Id);
        }

            List<Contact> contacts = [
                SELECT Id, AccountId, CreatedDate
                FROM Contact
                WHERE AccountId IN :acctIds
                ORDER BY CreatedDate ASC]; //Should I have tried to apply a limit? To ensure only one id is returned?

        Map<Id, Id> accountToContactMap = new Map<Id, Id>();
        for (Contact c : contacts) {
            accountToContactMap.put(c.AccountId, c.id);
        }

        for (Opportunity o : opportunites) {
            if (o.Primary_Contact__c == null) {
                o.Primary_Contact__c = accountToContactMap.get(o.account.Id);
            }
        }
        update opportunites;
    }
}