/**
 * File Name: AccountsServiceImpl 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountsServiceImpl
		implements IAccountsService
{
	public void copyShippingCountryToContacts(Set<Id> accountIds)
	{
		copyShippingCountryToContacts(Accounts.newInstance(accountIds));
	}

	public void copyShippingCountryToContacts(List<Account> records)
	{
		copyShippingCountryToContacts(Accounts.newInstance(records));
	}

	public void copyShippingCountryToContacts(IAccounts accounts)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		copyShippingCountryToContacts(unitOfWork, accounts);
		unitOfWork.commitWork();
	}

	public void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts)
	{
		Map<Id, String> shippingCountryByAccountId = accounts.getShippingCountryById();
		Set<Id> accountIds = accounts.getRecordIds();
		IContacts contacts = Contacts.newInstance(
				ContactsSelector.newInstance().selectByAccountId(accountIds)
		);
		contacts.setMailingCountryByAccountId(shippingCountryByAccountId);

		unitOfWork.registerDirty(contacts.getRecords());
	}

	public void recalculateRating(Set<Id> accountIds)
	{
		recalculateRating(
				Accounts.newInstance(accountIds)
		);
	}

	public void recalculateRating(List<Account> records)
	{
		recalculateRating(
				Accounts.newInstance(records)
		);
	}

	public void recalculateRating(IAccounts accounts)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		recalculateRating(unitOfWork, accounts);
		unitOfWork.commitWork();
	}

	public void recalculateRating(fflib_ISObjectUnitOfWork unitOfWork, IAccounts accounts)
	{
		accounts.selectByNumberOfEmployeesGreaterThan(99)
				.setRating('Hot');

		accounts.selectByNumberOfEmployeesLessThan(100)
				.setRating('Warm');

		unitOfWork.registerDirty(
				accounts.getRecords()
		);
	}
}