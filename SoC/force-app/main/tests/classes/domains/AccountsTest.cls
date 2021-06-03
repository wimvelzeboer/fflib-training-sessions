/**
 * File Name: AccountsTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@IsTest
private class AccountsTest
{
	@IsTest
	static void itShouldGetTheShippingCountryValues()
	{
		// GIVEN a domain with accounts containing ShippingCountry values
		Accounts domain = new Accounts(
				new List<Account>
				{
						new Account(ShippingCountry = 'USA'),
						new Account(ShippingCountry = 'Ireland'),
						new Account(ShippingCountry = 'Holland')
				});

		// WHEN we get the ShippingCountry values for the domain
		System.Test.startTest();
		Set<String> result = domain.getShippingCountries();
		System.Test.stopTest();

		// THEN the values should be returned
		System.assert(
				result.containsAll(
						new Set<String> { 'USA', 'Ireland', 'Holland' }
				)
		);
	}
}