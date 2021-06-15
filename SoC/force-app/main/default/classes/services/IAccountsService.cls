/**
 * File Name: IAccountsService 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public interface IAccountsService
{
	void copyShippingCountryToContacts(Set<Id> accountIds);
	void copyShippingCountryToContacts(List<Account> records);
	void copyShippingCountryToContacts(IAccounts accounts);
	void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts);

	void recalculateRating(Set<Id> accountIds);
	void recalculateRating(List<Account> records);
	void recalculateRating(IAccounts accounts);
	void recalculateRating(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts);
}