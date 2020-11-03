/**
 * File Name: AccountsImp
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
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
public class AccountTriggerHandlerImp
		extends fflib_SObjectDomain
		implements AccountTriggerHandler
{
	private AccountsService Service
	{
		get
		{
			if (Service == null)
			{
				Service =
						((AccountsService) Application.Service.newInstance(AccountsService.class));
			}
			return Service;
		}
		private set;
	}

	public AccountTriggerHandlerImp(List<Account> records)
	{
		super(records, Schema.Account.SObjectType);
	}

	public override void onAfterUpdate(Map<Id, SObject> existingRecords)
	{
		onChangedShippingCountryCopyCountryToContactMailingCountry();
	}

	private void onChangedShippingCountryCopyCountryToContactMailingCountry()
	{
		List<SObject> changedRecords = getChangedRecords(
				new Set<Schema.SObjectField>
				{
						Account.ShippingCountry
				}
		);

		if (changedRecords.isEmpty()) return;

		Service.copyShippingCountryToContacts(changedRecords);
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable2
	{
		public fflib_SObjectDomain construct(List<SObject> sObjectList)
		{
			return new AccountTriggerHandlerImp(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
		{
			return new AccountTriggerHandlerImp(sObjectList);
		}
	}
}