/**
 * File Name: Application
 * Description: Application configuration and routing file - using the Classic Binding Resolvers
 * <p/>
 * This file is part of an Apex EnterPrise Patterns Training.
 * <p/>
 * You can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or any later version.
 * <p/>
 * This file is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU General Public License
 * along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer
 */
public with sharing class Application
{
	public static fflib_BindingResolver Service = new fflib_ClassicBindingResolver(
			new Map<Type, Type>
			{
					OpportunitiesService.class => OpportunitiesServiceImp.class
			}
	);

	public static fflib_SelectorBindingResolver Selector = new fflib_ClassicSelectorBindingResolver(
			new Map<SObjectType, Type>
			{
					Account.SObjectType => AccountsSelectorImp.class,
					Opportunity.SObjectType => OpportunitiesSelectorImp.class
			});

	public static fflib_DomainBindingResolver Domain = new fflib_ClassicDomainBindingResolver(
			Application.Selector,
			new Map<SObjectType, Type>
			{
					Account.SObjectType => AccountsImp.Constructor.class,
					Opportunity.SObjectType => OpportunitiesImp.Constructor.class
			});


	// This will bind the defined event listener interfaces to it implementation
	public static final fflib_BindingResolver EventListenerBindings =
			new fflib_ClassicBindingResolver(
					new Map<Type, Type>
					{
							OnChangeOppLogActivityOnRelatedAccounts.class => OnChangeOppLogActivityOnRelatedAccImp.class
					}
			);

	public static final fflib_ApplicationEventEmitter EventEmitter =
			new fflib_ApplicationEventEmitterImp(

					// The Namespace of the application to emit the event.
					'MyNameSpace',

					// The selector that queries the event listeners (List<fflib_EventListenerConfig>),
					// The default is shown here but can be replaced with another selector
					// to retrieve the listeners from wherever they are stored
					fflib_MetadataEventListenerSelector.class,

					// The reference to the bindings to link interface and implementation
					Application.EventListenerBindings
			);
}