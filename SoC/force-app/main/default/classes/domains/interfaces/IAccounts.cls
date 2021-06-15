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
	IAccounts selectByNumberOfEmployeesGreaterThan(Integer amount);
	IAccounts selectByNumberOfEmployeesLessThan(Integer amount);
	IAccounts recalculateRating();

	Map<Id, String> getShippingCountryById();
}