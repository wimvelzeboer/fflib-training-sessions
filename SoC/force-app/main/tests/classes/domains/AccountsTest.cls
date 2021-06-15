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
						new Set<String> {'USA', 'Ireland', 'Holland'}
				)
		);
	}

	@IsTest
	static void itShouldSetTheRatingField()
	{
		// GIVEN a domain with a few records with no rating
		final String value = 'Hot';
		IAccounts domain = new Accounts(
				new List<Account>
				{
						new Account(),
						new Account()
				});

		// WHEN we set the rating to a value
		System.Test.startTest();
		domain.setRating(value);
		System.Test.stopTest();

		// THEN the rating should have the value
		List<Account> results = domain.getAccounts();
		System.assert(results.size() > 0);
		for (Account result : results)
		{
			System.assertEquals(value, result.Rating);
		}
	}

	@IsTest
	static void itShouldSelectByNumberOfEmployeesGreaterThan()
	{
		// GIVEN a domain with a few records with a value set for NumberOfEmployees
		IAccounts domain = new Accounts(
				new List<Account>
				{
						new Account(NumberOfEmployees = 1),
						new Account(NumberOfEmployees = 2),
						new Account(NumberOfEmployees = 3),
						new Account(NumberOfEmployees = 4),
						new Account(NumberOfEmployees = 5)
				});

		// WHEN we select the accounts with more than 3 employees
		System.Test.startTest();
		List<Account> results = domain.selectByNumberOfEmployeesGreaterThan(3)
				.getAccounts();
		System.Test.stopTest();

		// THEN we should have one record returned
		System.assert(results.size() == 2);
		for (Account result : results)
		{
			System.assert(result.NumberOfEmployees > 2);
		}
	}
}