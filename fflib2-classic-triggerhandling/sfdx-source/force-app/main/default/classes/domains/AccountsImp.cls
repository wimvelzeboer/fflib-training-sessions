/**
 * File Name: AccountsImp
 * Description: Domain implementation for the SObjectType Schema.Account
 *
 * This file is part of an Apex EnterPrise Patterns Training.
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
public with sharing class AccountsImp
		extends fflib_SObjects
		implements Accounts
{
	public AccountsImp(List<Object> objects)
	{
		super((List<SObject>) objects, Schema.Account.SObjectType);
	}

	/**
	 * Accessor method to get a list of Accounts
	 *
	 * @return List of Account SObjectType
	 */
	public List<Account> getAccounts()
	{
		return (List<Account>) getRecords();
	}

	/**
	 * Business logic method to log the day of the last activity on a linked opportunity record
	 */
	public void updateOpportunityActivity()
	{
		setDescription('Last Opportunity Raised ' + System.today());
	}

	/**
	 * Accessor method to set the value of the Description field
	 *
	 * @param value The new value for the Schema.Account.Description field
	 */
	public void setDescription(String value)
	{
		setFieldValue(Schema.Account.Description, value);
	}

	/**
	 * Class constructor used by the Application class to dynamically construct this domain implementation
	 */
	public class Constructor implements fflib_DomainConstructor
	{
		public fflib_Domain construct(List<Object> objects)
		{
			return new AccountsImp((List<Account>) objects);
		}
	}
}