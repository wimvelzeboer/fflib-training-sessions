#parse("Apex File Header.cls")

public with sharing class ${NAME}
{
	public static final fflib_Application.UnitOfWorkFactory UnitOfWork =
			new fflib_Application.UnitOfWorkFactory(
					new List<SObjectType>
					{
							Account.SObjectType,
							Contact.SObjectType
					});

	// Configure and create the ServiceFactory for this Application
	public static final fflib_Application.ServiceFactory Service =
			new fflib_Application.ServiceFactory(
			        new Map<Type, Type>
	                {
//                          AccountsService.class => AccountsService.class,
//			                ContactsService.class => ContactsService.class
	                }
	        );

	// Configure and create the SelectorFactory for this Application
	public static final fflib_Application.SelectorFactory Selector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
//                            Account.SObjectType => AccountsSelector_CLS.class,
//                            Attachment.SObjectType => AttachmentsSelector_CLS.class
					});

	// Configure and create the DomainFactory for this Application
	public static final fflib_Application.DomainFactory Domain =
			new fflib_Application.DomainFactory(
					Application_CLS.Selector,
					new Map<SObjectType, Type>
					{
//							Account.SObjectType => AccountsImp.Constructor.class,
//							Contact.SObjectType => ContactsImp.Constructor.class
					});
}