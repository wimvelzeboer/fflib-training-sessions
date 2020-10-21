/**
 * File Name: ContactsSelector 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface ContactsSelector extends fflib_ISObjectSelector
{
	List<Contact> selectByAccountId(Set<Id> accountsRecordIds);
}