/**
 * File Name: OnChangeOppLogActivityOnRelatedAccImp
 * Description: Event Listener implementation on Opportunities to log the last Activity date on the related Account records
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
public with sharing class OnChangeOppLogActivityOnRelatedAccImp
		extends fflib_SObjectEventListener
		implements OnChangeOppLogActivityOnRelatedAccounts
{

	/**
	 * This links the listener to the Trigger Operation Type and executed the required business logic
	 */
	public override void onAfterInsert()
	{
		// Business logic is split in one or more main steps listed here as method calls.
		updateOpportunityActivityOnRelatedAccounts();
	}

	/**
	 * This links the listener to the Trigger Operation Type and executed the required business logic
	 */
	public override void onAfterUpdate()
	{
		// Business logic is split in one or more main steps listed here as method calls.
		updateOpportunityActivityOnRelatedAccounts();
	}

	/**
	 * High level business logic calling Selectors, Domains and Service class methods
	 */
	private void updateOpportunityActivityOnRelatedAccounts()
	{
		Set<Id> accountIds = newOpportunitiesDomain(records).getAccountIds();

		Accounts accounts = newAccountsDomain(accountIds);
		accounts.updateOpportunityActivity();
		update accounts.getAccounts();
	}

	private Accounts newAccountsDomain(Set<Id> accountIds)
	{
		return (Accounts) Application.Domain.newInstance(accountIds);
	}

	private Opportunities newOpportunitiesDomain(List<SObject> records)
	{
		return (Opportunities) Application.Domain.newInstance(records, Opportunity.SObjectType);
	}
}