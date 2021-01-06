/**
 * File Name: OpportunitiesImp
 * Description: Domain implementation for the SObjectType Schema.Opportunity
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
public with sharing class OpportunitiesImp
		extends fflib_SObjects
		implements Opportunities
{

	public OpportunitiesImp(List<Object> objects)
	{
		super((List<SObject>) objects, Schema.Opportunity.SObjectType);
	}

	/**
	 * Accessor method to get a set of AccountIds
	 *
	 * @return Set of Schema.Opportunity.AccountId
	 */
	public Set<Id> getAccountIds()
	{
		return getIdFieldValues(Schema.Opportunity.AccountId);
	}

	/**
	 * Class constructor used by the Application class to dynamically construct this domain implementation
	 */
	public class Constructor implements fflib_DomainConstructor
	{
		public fflib_Domain construct(List<Object> objects)
		{
			return new OpportunitiesImp((List<Opportunity>) objects);
		}
	}
}