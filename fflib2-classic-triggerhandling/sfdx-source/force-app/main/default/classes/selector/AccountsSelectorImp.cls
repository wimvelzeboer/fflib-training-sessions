/**
 * File Name: AccountsSelectorImp 
 * Description: Selector implementation for the SObjectType Schema.Account
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
public class AccountsSelectorImp extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Account.Id,
				Account.Description
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