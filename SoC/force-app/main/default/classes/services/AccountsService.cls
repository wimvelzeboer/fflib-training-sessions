/**
 * File Name: MyWebService
 * Description:
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountsService
{
	private AccountsService() {}

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