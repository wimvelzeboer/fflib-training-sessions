/**
 * File Name: OpportunityTrigger 
 * Description: Trigger for Opportunities emitting a SObjectEvent
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
trigger OpportunityTrigger on Opportunity
		(before insert, before update, before delete, after insert, after update, after delete, after undelete)
{
	Application.EventEmitter.emit(new fflib_SObjectEvent());
}