/**
 * File Name: ContactsSelectorImp 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public class ContactsSelectorImp
		extends fflib_SObjectSelector
		implements ContactsSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id,
				Contact.AccountId,
				Contact.MailingCountry
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Contact.SObjectType;
	}

	public List<Contact> selectById(Set<Id> idSet)
	{
		return (List<Contact>) selectSObjectsById(idSet);
	}

	public List<Contact> selectByAccountId(Set<Id> idSet)
	{
		return (List<Contact>) Database.query(
				newQueryFactory()
						.setCondition('AccountId IN :idSet')
						.toSOQL()
		);
	}
}