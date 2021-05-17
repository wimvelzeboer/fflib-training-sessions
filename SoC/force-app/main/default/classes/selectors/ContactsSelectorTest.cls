/**
 * File Name: ContactsSelectorTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
@IsTest
private class ContactsSelectorTest
{
	@IsTest
	static void testBehavior()
	{
		Account account = new Account(Name = 'Test');
		insert account;
		Contact contact = new Contact(LastName = 'Smith', AccountId = account.Id);
		insert contact;

		Profile profile = [SELECT Id FROM Profile WHERE Name = 'Read Only'];

		User testUser = new User(
				Alias = 'Black',
				LastName = 'Black',
				Username = 'TestUser.Black@example.com',
				Email = 'TestUser.Black@example.com',

				EmailEncodingKey='UTF-8',
				LanguageLocaleKey='en_US',
				LocaleSidKey='en_US',
				TimeZoneSidKey='America/Los_Angeles',

				ProfileId = profile.Id
		);

		System.assert([SELECT COUNT() FROM Contact] == 1);

		List<Contact> testData = ContactsSelector.newInstance().selectByAccountId(new Set<Id> {account.Id});
		System.assert(testData.size() == 1, 'Test Data selector Failed');


		System.runAs(testUser)
		{
			System.debug('Select Contact with AccountId : '+account.Id);
			List<Contact> contacts = ContactsSelector.newWithoutSharingInstance().selectByAccountId(new Set<Id> {account.Id});
			System.assert([SELECT COUNT() FROM Contact WHERE AccountId = :account.Id] == 0, 'SOQL 1 failed');
			System.assert([SELECT COUNT() FROM Contact] == 0, 'SOQL 2 failed');
			System.assert(contacts.size() == 1, 'Selector Failed');
		}
	}
}