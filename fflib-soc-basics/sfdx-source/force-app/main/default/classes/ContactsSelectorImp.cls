/**
 * File Name: ContactsSelectorImp 
 * Description: 
 *
 *  This file is part of an Apex EnterPrise Training.
 *
 *  You can redistribute it and/or modify it under the terms of the
 *  GNU General Public License as published by the Free Software
 *  Foundation, either version 3 of the License, or any later version.
 *
 *  This file is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com
 */
public class ContactsSelectorImp extends fflib_SObjectSelector implements ContactsSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Contact.SObjectType;
	}

	public List<Contact> selectById(Set<Id> idSet)
	{
		return (List<Contact>) selectSObjectsById(idSet);
	}

	public List<Contact> selectByAccountId(Set<Id> accountIds)
	{
		return (List<Contact>) Database.query(
				newQueryFactory()
						.setCondition('AccountId IN :accountIds')
						.toSOQL()
		);
	}
}