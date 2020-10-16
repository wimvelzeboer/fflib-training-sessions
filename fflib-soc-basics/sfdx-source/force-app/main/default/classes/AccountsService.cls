/**
 * File Name: AccountsService 
 * Description: 
 * Copyright (c) 2020 Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface AccountsService
{
	void copyShippingCountryToContacts(Set<Id> idSet);
	void copyShippingCountryToContacts(List<Account> records);
	void copyShippingCountryToContacts(Accounts accounts);
	void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, Accounts accounts);
}