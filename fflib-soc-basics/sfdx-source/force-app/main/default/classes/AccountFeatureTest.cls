/**
 * File Name: AccountFeatureTest
 * Description:
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com
 */
@IsTest
private class AccountFeatureTest
{
	@IsTest
	static void testBehavior()
	{
//		GIVEN an account with contact records
		Account account = new Account(Name = 'test');
		insert account;

		List<Contact> contacts = new List<Contact>
		{
				new Contact(LastName = 'Jack', AccountId = account.Id),
				new Contact(LastName = 'John', AccountId = account.Id),
				new Contact(LastName = 'Jill', AccountId = account.Id)
		};
		insert contacts;

//		WHEN the ShippingCountry is changed on the account record
		account.ShippingCountry = 'Holland';
		update account;

//		THEN the ShippingCountry should be copied to the MailingCountry field
//		on all the child contacts of the account
		List<Contact> result = [SELECT MailingCountry FROM Contact];
		System.assert(result.size() == 3);
		for (Contact contact : result)
		{
			System.assertEquals('Holland', contact.MailingCountry);
		}
	}
}