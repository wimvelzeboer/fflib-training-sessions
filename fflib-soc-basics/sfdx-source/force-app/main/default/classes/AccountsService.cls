/**
 * File Name: AccountsService 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface AccountsService
{
	void copyShippingCountryToContacts(Set<Id> idSet);
	void copyShippingCountryToContacts(List<Account> records);
	void copyShippingCountryToContacts(Accounts account);
	void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, Accounts account);
}