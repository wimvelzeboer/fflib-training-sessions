# AEP 2.0 Training - Classic Trigger Handler


## Contents

- [The User Story](#the-user-story)
- [Feature Test](#feature-test)

## The User story

### Business user story
> **AS** Sales Agent<br/>
> **I WANT TO** view and Account and see directly the last date of activity on its opportunities <br/> 
> **SO THAT** I can estimate the Account Rating better and know if I would need another follow-up call

### Implementation/Testing scenarios
> **GIVEN** An Opportunity linked to an Account record<br/>
> **WHEN** The Opportunity is changed<br/>
> **THEN** The Account.Description field should be updated to "Last Opportunity Raised {CURRENTDATE}"

> **GIVEN** An Account record<br/>
> **WHEN** A new opportunity is created for that Account<br/>
> **THEN** The Account.Description field should be updated to "Last Opportunity Raised {CURRENTDATE}"

### Technical Design
When writing the Technical Design for the business logic, 
it is important to know what domains the logic is crossing and on which domain it starts.
In this case the logic is initiated by a change on Opportunity, therefore it should be either Opportunity Domain or Service logic.
The user story spans across two domains; Opportunity & Accounts, it also interacts with the database.
The fact that it is cross domain and interacts with a database means that the business logic should be developed in the Opportunity Service class

> **TO** log the last Opportunity activity date to the current date<br/>
> **WE** get the Account Ids from the Opportunities<br/>
> **THEN** get the Account Records<br/>
> **AND** set the Last Opportunity Raised Date to the current Date 

## Feature Test
Since there are two implementation scenarios, there should be two feature integration tests;

- When a new opportunity is created 
- When an opportunity is changed

Let's start by creating a test class named `LastOpportunityActivityFeatureTest`,
the test methods; `opportunityIsCreated` and `opportunityIsChanged`
and copy in the implementation/test scenario.

```apex
@IsTest
private class LastOpportunityActivityFeatureTest
{
    @IsTest
    static void opportunityIsCreated()
    {
        // GIVEN An Account record
        // WHEN A new opportunity is created for that Account
        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
    }

    @IsTest
    static void opportunityIsChanged()
    {
        // GIVEN An Opportunity linked to an Account record
        // WHEN The Opportunity is changed
        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
    }
}
```

Now let's write the test code for the first method. We first need to create an account, then an opportunity. 
That should trigger the logic and get the desired result.
```apex
@IsTest
private class LastOpportunityActivityFeatureTest
{
    @IsTest
    static void opportunityIsCreated()
    {
        // GIVEN An Account record
        Account account = new Account(Name = 'Test Account');
        insert account;

        // WHEN A new opportunity is created for that Account
        Opportunity opportunity = new Opportunity(
                Name = 'Test',
                StageName = 'Open',
                CloseDate = System.Date.today(),
                AccountId = account.Id);
        insert opportunity;

        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
        Account result = [SELECT Description FROM Account WHERE Id = :account.Id];
        System.assertEquals('Last Opportunity Raised ' + Date.today(), result.Description, 'Account description field not correctly updated');
    }

    @IsTest
    static void opportunityIsChanged()
    {
        // GIVEN An Opportunity linked to an Account record
        // WHEN The Opportunity is changed
        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
    }
}
```
For the second test method we can start by copying the data creation logic from the first method.
Then we make a change to the opportunity and assert for the expected result.

Since we already insert the opportunity in the test data creation the on-creation-logic should already been triggered.
So, we need to reset the value of the Account.Description field to make sure we have valid test data to begin with.

```apex
@IsTest
private class LastOpportunityActivityFeatureTest
{
    ...

    @IsTest
    static void opportunityIsChanged()
    {
        // GIVEN An Opportunity linked to an Account record
        Account account = new Account(Name = 'Test Account');
        insert account;
        Opportunity opportunity = new Opportunity(
                Name = 'Test',
                StageName = 'Open',
                CloseDate = System.Date.today(),
                AccountId = account.Id);
        insert opportunity;
        account.Description = '';
        update account;
        System.assert(String.isBlank([SELECT Id, Description FROM Account WHERE Id = :account.Id].Description));
        
        // WHEN The Opportunity is changed
        System.Test.startTest();
        opportunity.Description = 'Test';
        update opportunity;
        System.Test.stopTest();
        
        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
        Account result = [SELECT Description FROM Account WHERE Id = :account.Id];
        System.assertEquals('Last Opportunity Raised ' + Date.today(), result.Description, 'Account description field not correctly updated'
        );
    }
}
```
Now that we have the tests we can save and run them. 
The assertions should obviously fail, as the logic has not been implemented yet.
Before we start working on implementing the logic, we need to do some clean up.
We have quite some duplicated code we should extract into private methods.
The duplications are in particular wiht the data creation.
Here is how it looks after the refactoring.


@IsTest
    private class LastOpportunityActivityFeatureTest
    {
    @IsTest
    static void opportunityIsChanged()
    {
        // GIVEN An Opportunity linked to an Account record
        Account account = insertAccount();
        Opportunity opportunity = insertOpportunity(account);
        account.Description = '';
        update account;
        System.assert(String.isBlank([SELECT Id, Description FROM Account WHERE Id = :account.Id].Description));

        // WHEN The Opportunity is changed
        System.Test.startTest();
        opportunity.Description = 'Test';
        update opportunity;
        System.Test.stopTest();

        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
        Account result = [SELECT Description FROM Account WHERE Id = :account.Id];
        System.assertEquals(
                'Last Opportunity Raised ' + Date.today(), 
                result.Description, 
                'Account description field not correctly updated'
        );
    }

    @IsTest
    static void opportunityIsCreated()
    {
        // GIVEN An Account record
        Account account = insertAccount();

        // WHEN A new opportunity is created for that Account
        Opportunity opportunity = insertOpportunity(account);

        // THEN The Account.Description field should be updated to "Last Opportunity Raised {CURRENT_DATE}"
        Account result = [SELECT Description FROM Account WHERE Id = :account.Id];
        System.assertEquals(
                'Last Opportunity Raised ' + Date.today(), 
                result.Description, 
                'Account description field not correctly updated'
        );
    }

    private static Account insertAccount()
    {
        Account account = new Account(Name = 'Test Account');
        insert account;
        return account;
    }

    private static Opportunity insertOpportunity(Account account)
    {
        Opportunity opportunity = new Opportunity(
                Name = 'Test',
                StageName = 'Open',
                CloseDate = System.Date.today(),
                AccountId = account.Id);
        insert opportunity;
        return opportunity;
    }
}
```
 