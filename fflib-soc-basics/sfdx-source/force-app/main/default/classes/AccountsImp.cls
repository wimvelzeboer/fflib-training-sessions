/**
 * File Name: AccountsImp 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public with sharing class AccountsImp
		extends fflib_SObjectDomain
		implements Accounts
{
	private AccountsService Service
	{
		get
		{
			if (Service == null)
			{
				Service =
						((AccountsService) Application.Service.newInstance(AccountsService.class));
			}
			return Service;
		}
		private set;
	}

	public AccountsImp(List<Account> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	public Map<Id, String> getShippingCountryById()
	{
		Map<Id, String> result = new Map<Id, String>();
		for (Account record : (List<Account>) getRecords())
		{
			result.put(record.Id, record.ShippingCountry);
		}
		return result;
	}

	public Set<Id> getRecordIds()
	{
		Set<Id> result = new Set<Id>();
		for (SObject record : getRecords())
		{
			result.add(record.Id);
		}
		return result;
	}

	public override void onAfterUpdate(Map<Id, SObject> existingRecords)
	{
		onChangeShippingCountryCopyCountryToContacts();
	}

	private void onChangeShippingCountryCopyCountryToContacts()
	{
		List<SObject> changedRecords = getChangedRecords(new Set<Schema.SObjectField>
		{
				Account.ShippingCountry
		});

		if (changedRecords.isEmpty()) return;

		new AccountsImp(changedRecords).copyCountryToContactMailingCountry();
	}

	public void copyCountryToContactMailingCountry()
	{
		Service.copyShippingCountryToContacts(this);
	}


	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new AccountsImp(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new AccountsImp(sObjectList);
		}
	}
}