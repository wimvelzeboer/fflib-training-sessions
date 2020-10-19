#parse("Apex File Header.cls")

// Click on each word below, click CONTROL-COMMAND-G, change it into the desired name and remove this comment afterwards
// SOBJECTNAME

public class ${NAME} extends fflib_SObjectDomain 
{

   	public ${NAME}(List<SOBJECTNAME> records) 
	{
		super(records, Schema.SOBJECTNAME.SObjectType);	
	}


	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new ${NAME}(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new ${NAME}(sObjectList);
		}			
	}	
}