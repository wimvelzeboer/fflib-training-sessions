/**
 * File Name: Application 
 * Description: generates instances of the application components
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class Application
{
	public static fflib_Application.SelectorFactory Selector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
							Account.SObjectType => AccountsSelector.class,
							Case.SObjectType => CasesSelector.class,
							Contact.SObjectType => ContactsSelector.class
					});

	public static fflib_Application.SelectorFactory WithoutSharingSelector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
							//  Account.SObjectType => AccountsSelectorImp.class,
							Contact.SObjectType => ContactsSelector.WithoutSharing.class
					});

	public static fflib_Application.SelectorFactory WithSharingSelector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
							//  Account.SObjectType => AccountsSelectorImp.class,
							Contact.SObjectType => ContactsSelector.WithSharing.class
					});

	public static fflib_Application.DomainFactory Domain =
			new fflib_Application.DomainFactory(
					Application.Selector,
					new Map<SObjectType, Type>
					{
							Account.SObjectType => Accounts.Constructor.class
					});
}