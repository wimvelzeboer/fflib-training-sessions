/**
 * File Name: AccountsServiceImp
 * Description:
 *
 * This file is part of an Apex EnterPrise Training.
 *
 * You can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or any later version.
 *
 * This file is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
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