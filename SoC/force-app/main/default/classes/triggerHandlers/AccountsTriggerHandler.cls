/**
 * File Name: AccountsTriggerHandler
 * Description:
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountsTriggerHandler extends fflib_SObjectDomain
{
	public AccountsTriggerHandler(List<Account> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	public override void onBeforeInsert()
	{
		recalculateRating();
	}

	public override void onBeforeUpdate(Map<Id, SObject> existingRecords)
	{
		onChangedNumberOfEmployeesRecalculateRating();
		onChangedCountryCopyValueToContacts();
	}

	private void onChangedCountryCopyValueToContacts()
	{
		List<SObject> changedRecords = getChangedRecords(new Set<SObjectField> {Schema.Account.ShippingCountry });

		if (changedRecords.isEmpty()) return;

		AccountsService.copyShippingCountryToContacts((List<Account>) changedRecords);
	}

	private void onChangedNumberOfEmployeesRecalculateRating()
	{
		List<SObject> changedRecords = getChangedRecords(new Set<SObjectField> {Schema.Account.NumberOfEmployees});

		if (changedRecords.isEmpty()) return;

		new AccountsTriggerHandler(changedRecords)
				.recalculateRating();
	}

	private void recalculateRating()
	{
		Accounts.newInstance(getRecords())
				.recalculateRating();
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new AccountsTriggerHandler(sObjectList);
		}
	}
}


