/**
 * File Name: AccountsServiceImp
 * Description:
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com
 */
public with sharing class AccountsServiceImp implements AccountsService
{
	private ContactsSelector ContactsSelector
	{
		get
		{
			if (ContactsSelector == null)
			{
				ContactsSelector =
						((ContactsSelector) Application.Selector.newInstance(Schema.Contact.SObjectType));
			}
			return ContactsSelector;
		}
		private set;
	}

	public void copyShippingCountryToContacts(Set<Id> idSet)
	{
		copyShippingCountryToContacts(
				(Accounts) Application.Domain.newInstance(idSet)
		);
	}

	public void copyShippingCountryToContacts(List<Account> records)
	{
		copyShippingCountryToContacts(
				(Accounts) Application.Domain.newInstance(records)
		);
	}

	public void copyShippingCountryToContacts(Accounts accounts)
	{
		fflib_ISObjectUnitOfWork unitOfWork = Application.UnitOfWork.newInstance();
		copyShippingCountryToContacts(unitOfWork, accounts);
		unitOfWork.commitWork();
	}

	public void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, Accounts accounts)
	{
		Map<Id, String> shippingCountryById = accounts.getShippingCountryById();
		Contacts contacts = getContacts(accounts);
		contacts.setMailingCountryByAccountId(shippingCountryById);
		unitOfWork.registerDirty(contacts.getRecords());
	}

	private Contacts getContacts(Accounts accounts)
	{
		return (Contacts) Application.Domain.newInstance(
				ContactsSelector.selectByAccountId(accounts.getRecordIds())
		);
	}
}