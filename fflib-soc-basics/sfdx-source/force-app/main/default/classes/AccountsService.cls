/**
 * File Name: AccountsService 
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
public interface AccountsService
{
	void copyShippingCountryToContacts(Set<Id> idSet);
	void copyShippingCountryToContacts(List<Account> records);
	void copyShippingCountryToContacts(Accounts accounts);
	void copyShippingCountryToContacts(fflib_ISObjectUnitOfWork unitOfWork, Accounts accounts);
}