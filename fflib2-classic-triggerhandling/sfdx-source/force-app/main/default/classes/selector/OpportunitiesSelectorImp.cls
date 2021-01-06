/**
 * File Name: OpportunitiesSelectorImp 
 * Description: Selector implementation for the SObjectType Schema.Opportunity
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
public class OpportunitiesSelectorImp extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Opportunity.Id,
				Opportunity.AccountId
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Opportunity.SObjectType;
	}

	public List<Opportunity> selectById(Set<Id> idSet)
	{
		return (List<Opportunity>) selectSObjectsById(idSet);
	}
}