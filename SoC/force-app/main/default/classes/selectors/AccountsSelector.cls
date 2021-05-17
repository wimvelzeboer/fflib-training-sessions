/**
 * File Name: AccountsSelector 
 * Description: Selector implementation for Account records
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public virtual inherited sharing class AccountsSelector
		extends fflib_SObjectSelector
		implements IAccountsSelector
{
	public static IAccountsSelector newInstance()
	{
		return (IAccountsSelector) Application.Selector.newInstance(Schema.Account.SObjectType);
	}

	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Account.Id,
				Account.AccountNumber,
				Account.Name,
				Account.Rating,
				Account.ShippingCountry
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Account.SObjectType;
	}

	public List<Account> selectById(Set<Id> idSet)
	{
		return (List<Account>) selectSObjectsById(idSet);
	}
}