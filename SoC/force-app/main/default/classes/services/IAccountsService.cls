/**
 * File Name: IAccountsService 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public interface IAccountsService
{
	void recalculateRating(Set<Id> accountIds);
	void recalculateRating(List<Account> records);
	void recalculateRating(IAccounts accounts);
}