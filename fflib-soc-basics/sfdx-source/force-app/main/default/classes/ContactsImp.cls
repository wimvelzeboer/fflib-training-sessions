/**
 * File Name: ContactsImp 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public with sharing class ContactsImp extends fflib_SObjectDomain implements Contacts
{
	public ContactsImp(List<Contact> records)
	{
		super(records, Schema.Contact.SObjectType);
	}

	public void setMailingCountryByAccountId(Map<Id, String> countryById)
	{
		for (Contact record : getContacts())
		{
			if (countryById.containsKey(record.AccountId))
			{
				record.MailingCountry = countryById.get(record.AccountId);
			}
		}
	}

	private List<Contact> getContacts()
	{
		return (List<Contact>) getRecords();
	}


	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new ContactsImp(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new ContactsImp(sObjectList);
		}
	}

}