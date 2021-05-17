/**
 * File Name: CasesSelector 
 * Description: Selector implementation for Case records
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public virtual inherited sharing class CasesSelector
		extends fflib_SObjectSelector
		implements ICasesSelector
{
	public static ICasesSelector newInstance()
	{
		return (ICasesSelector) Application.Selector.newInstance(Schema.Case.SObjectType);
	}

	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Case.Id,
				Case.CaseNumber,
				Case.Priority,
				Case.Status,
				Case.Subject
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Case.SObjectType;
	}

	public List<Case> selectById(Set<Id> idSet)
	{
		return (List<Case>) selectSObjectsById(idSet);
	}
}