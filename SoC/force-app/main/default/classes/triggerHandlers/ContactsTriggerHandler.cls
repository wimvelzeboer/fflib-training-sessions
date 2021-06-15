/**
 * File Name: ContactsTriggerHandler 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public class ContactsTriggerHandler extends fflib_SObjectDomain
{

	public ContactsTriggerHandler(List<Contact> records)
	{
		super(records, Schema.Contact.SObjectType);
	}

	public override void onAfterInsert()
	{
		increaseNumberOfEmployees();
	}

	private void increaseNumberOfEmployees()
	{
//		ContactsService.increaseAccountNumberOfEmployees();
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new ContactsTriggerHandler(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new ContactsTriggerHandler(sObjectList);
		}
	}
}