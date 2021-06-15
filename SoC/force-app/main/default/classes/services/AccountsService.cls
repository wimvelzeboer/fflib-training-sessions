/**
 * File Name: MyWebService
 * Description:
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountsService
{
	private AccountsService() {}

	public static void copyShippingCountryToContacts(Set<Id> accountIds)
	{
		service().copyShippingCountryToContacts(accountIds);
	}

	public static void copyShippingCountryToContacts(List<Account> records)
	{
		service().copyShippingCountryToContacts(records);
	}

	public static void copyShippingCountryToContacts(IAccounts accounts)
	{
		service().copyShippingCountryToContacts(accounts);
	}

	public static void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts)
	{
		service().copyShippingCountryToContacts(unitOfWork, accounts);
	}

	public static void recalculateRating(Set<Id> accountIds)
	{
		service().recalculateRating(accountIds);
	}

	public static void recalculateRating(List<Account> records)
	{
		service().recalculateRating(records);
	}

	public static void recalculateRating(IAccounts accounts)
	{
		service().recalculateRating(accounts);
	}

	private static IAccountsService service()
	{
		return (IAccountsService) Application.Service.newInstance(IAccountsService.class);
	}
}