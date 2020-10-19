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
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public class AccountsImp extends fflib_SObjectDomain implements Accounts
{
    public AccountsImp(List<Account> records)
    {
        super(records);
    }

    public Map<Id, String> getShippingCountryById()
    {
        Map<Id, String> result = new Map<Id, String>();
        for (Account record : (List<Account>) getRecords())
        {
            result.put(record.Id, record.ShippingCountry);
        }
        return result;
    }

    public Set<Id> getRecordIds()
    {
        Set<Id> result = new Set<Id>();
        for (Account record : (List<Account>) getRecords())
        {
            result.add(record.Id);
        }
        return result;
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable2
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new AccountsImp(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
        {
            return new AccountsImp(sObjectList);
        }
    }
}