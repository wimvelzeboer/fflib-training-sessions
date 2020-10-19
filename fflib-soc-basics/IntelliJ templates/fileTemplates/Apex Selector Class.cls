#parse("Apex File Header.cls")

// Click on each word below, click CONTROL-COMMAND-G, change it into the desired name and remove this comment afterwards
// SOBJECTNAME

public class ${NAME} extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
				SOBJECTNAME.Id
			};
	}

	public Schema.SObjectType getSObjectType()
	{
		return SOBJECTNAME.SObjectType;
	}

	public List<SOBJECTNAME> selectById(Set<Id> idSet)
	{
		return (List<SOBJECTNAME>) selectSObjectsById(idSet);
	}	

	public List<SOBJECTNAME> selectBySomethingElse(List<String> names)
	{
		return (List<SOBJECTNAME>) Database.query(
		        newQueryFactory()
		        .selectField('Name')
		        .setCondition('Name IN :names')
		        .toSOQL()
		);
	}
}