/**
 * File Name: Application 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public with sharing class Application
{
	public static fflib_Application.SelectorFactory Selector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
							Contact.SObjectType => ContactsSelectorImp.class
					});

	public static fflib_Application.DomainFactory Domain =
			new fflib_Application.DomainFactory(
					Application.Selector,
					new Map<SObjectType, Type>
					{
							Account.SObjectType => AccountsImp.Constructor.class,
							Contact.SObjectType => ContactsImp.Constructor.class
					});
	public static fflib_Application.UnitOfWorkFactory UnitOfWork  =
			new fflib_Application.UnitOfWorkFactory(
					new List<SObjectType>
					{
							Account.SObjectType,
							Contact.SObjectType
					});
}