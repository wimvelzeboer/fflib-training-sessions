/**
 * File Name: ContactsTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@IsTest
private class ContactsTest
{
	@IsTest
	static void itShouldGetTheMailingCountryById()
	{
		// GIVEN a Domain with contacts related to accounts
		Id accountIdA = fflib_IDGenerator.generate(Schema.Account.SObjectType);
		Id accountIdB = fflib_IDGenerator.generate(Schema.Account.SObjectType);

		List<Contact> contactRecords = new List<Contact>
		{
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdA),
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdA),
				new Contact(Id = fflib_IDGenerator.generate(Schema.Contact.SObjectType), AccountId = accountIdB)
		};
		IContacts domain = Contacts.newInstance(contactRecords);

		Map<Id, String> countryByAccountId = new Map<Id, String>
		{
				accountIdA => 'Ireland',
				accountIdB => 'Holland'
		};

		// WHEN
		System.Test.startTest();
		domain.setMailingCountryByAccountId(countryByAccountId);
		List<Contact> result = (List<Contact>) domain.getRecords();
		System.Test.stopTest();

		// THEN
		for (Contact contact : result)
		{
			System.assertEquals(
					countryByAccountId.get(contact.AccountId),
					contact.MailingCountry
			);
		}
	}
}