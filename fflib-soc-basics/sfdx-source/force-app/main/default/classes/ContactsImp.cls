/**
 * File Name: ContactsImp 
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
public with sharing class ContactsImp extends fflib_SObjectDomain implements Contacts
{

    public ContactsImp(List<Contact> records)
    {
        super(records);
    }

    public void setMailingCountryByAccountId(Map<Id, String> shippingCountryById)
    {
        for (Contact record : (List<Contact>) getRecords())
        {
            if (shippingCountryById.containsKey(record.AccountId))
            {
                record.MailingCountry = shippingCountryById.get(record.AccountId);
            }
        }
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable2
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new ContactsImp(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
        {
            return new ContactsImp(sObjectList);
        }
    }
}