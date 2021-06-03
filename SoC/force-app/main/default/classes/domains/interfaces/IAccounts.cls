/**
 * File Name: IAccounts 
 * Description: Method signature definitions for Account domain class
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public interface IAccounts extends fflib_ISObjects
{
	List<Account> getAccounts();
	void setRating(String value);
	Set<String> getShippingCountries();
}