/**
 * File Name: Accounts 
 * Description: Domain implementation for Account records
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class Accounts
		extends fflib_SObjects
		implements IAccounts
{
    // Class constructor
	@TestVisible
	private Accounts(List<SObject> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	// Method to create new domain instances via record Ids
	public static IAccounts newInstance(Set<Id> ids)
	{
		return (IAccounts) Application.Domain.newInstance(ids);
	}

	// Method to create new domain instances via records
	public static IAccounts newInstance(List<SObject> records)
	{
		return (IAccounts) Application.Domain.newInstance(records, Schema.Account.sObjectType);
	}

	public List<Account> getAccounts()
	{
		return (List<Account>) getRecords();
	}

	public Set<String> getShippingCountries()
	{
		Set<String> result = new Set<String>();
		for (Account record : getAccounts())
		{
			result.add(record.ShippingCountry);
		}
		return result;
	}

	public Map<Id, String> getShippingCountryById()
	{
		Map<Id, String> result = new Map<Id, String>();
		for (Account record : getAccounts())
		{
			if (String.isBlank(record.ShippingCountry)) continue;

			result.put(record.Id, record.ShippingCountry);
		}
		return result;
	}

	public IAccounts recalculateRating()
	{
		selectByNumberOfEmployeesGreaterThan(99)
				.setRating('Hot');

		selectByNumberOfEmployeesLessThan(100)
				.setRating('Warm');

		return (IAccounts) this;
	}

	public IAccounts selectByNumberOfEmployeesGreaterThan(Integer amount)
	{
		List<Account> result = new List<Account>();
		for (Account record : getAccounts())
		{
			if (record.NumberOfEmployees != null && record.NumberOfEmployees > amount)
			{
				result.add(record);
			}
		}
		return (IAccounts) new Accounts(result);
	}

	public IAccounts selectByNumberOfEmployeesLessThan(Integer amount)
	{
		List<Account> result = new List<Account>();
		for (Account record : getAccounts())
		{
			if (record.NumberOfEmployees != null && record.NumberOfEmployees < amount)
			{
				result.add(record);
			}
		}
		return (IAccounts) new Accounts(result);
	}

	public void setRating(String value)
	{
		for (Account record : getAccounts())
		{
			record.Rating = value;
		}
	}

	// Sub-class constructor
	public class Constructor implements fflib_IDomainConstructor
	{
		public fflib_IDomain construct(List<Object> objectList)
		{
			return (fflib_IDomain) new Accounts((List<SObject>) objectList);
		}
	}
}