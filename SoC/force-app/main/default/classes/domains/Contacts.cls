/**
 * File Name: Contacts
 * Description: Domain implementation for Contact records
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class Contacts
		extends fflib_SObjects
		implements IContacts
{
	// Class constructor
	@TestVisible
	private Contacts(List<SObject> records)
	{
		super(records, Schema.Contact.SObjectType);
	}

	// Method to create new domain instances via record Ids
	public static IContacts newInstance(Set<Id> ids)
	{
		return (IContacts) Application.Domain.newInstance(ids);
	}

	// Method to create new domain instances via records
	public static IContacts newInstance(List<SObject> records)
	{
		return (IContacts) Application.Domain.newInstance(records, Schema.Contact.SObjectType);
	}

	public List<Contact> getContacts()
	{
		return (List<Contact>) getRecords();
	}

	public void setMailingCountryByAccountId(Map<Id, String> countryByAccountId)
	{
		for (Contact record : getContacts())
		{
			if (countryByAccountId.containsKey(record.Id))
			{
				record.MailingCountry = countryByAccountId.get(record.Id);
			}
		}
	}

	// Sub-class constructor
	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_IDomain construct(List<Object> objectList)
		{
			return (fflib_IDomain) new Contacts((List<SObject>) objectList);
		}
	}
}