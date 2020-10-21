/**
 * File Name: Accounts 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface Accounts extends fflib_ISObjectDomain
{
	Map<Id, String> getShippingCountryById();

	Set<Id> getRecordIds();
}