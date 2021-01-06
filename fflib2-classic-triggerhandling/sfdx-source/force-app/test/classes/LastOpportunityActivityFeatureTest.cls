/**
 * File Name: LastOpportunityActivityFeatureTest
 * Description: Feature integration test
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
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
		System.assertEquals('Last Opportunity Raised ' + Date.today(), result.Description, 'Account description field not correctly updated');
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
		System.assertEquals('Last Opportunity Raised ' + Date.today(), result.Description, 'Account description field not correctly updated');
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
