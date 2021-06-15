/**
 * File Name: IContacts 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public interface IContacts extends fflib_ISObjects
{
	void setMailingCountryByAccountId(Map<Id, String> stringsByIds);

}