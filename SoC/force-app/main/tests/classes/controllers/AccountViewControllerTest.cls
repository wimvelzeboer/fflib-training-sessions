/**
 * File Name: AccountViewControllerTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@IsTest
private class AccountViewControllerTest
{
	@IsTest
	static void testBehavior()
	{
        // GIVEN - a Race record
        Account record = new Account(Id = fflib_IDGenerator.generate(Schema.Account.SObjectType));

        ApexPages.StandardController standardController =
                new ApexPages.StandardController(record);

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IAccountsService serviceMock = (IAccountsService) mocks.mock(IAccountsService.class);
		Application.Service.setMock(IAccountsService.class, serviceMock);

        // WHEN - The UI calls the controller method onRecalculateRating
        PageReference result =
                new AccountViewController(standardController)
                        .onRecalculateRatingButtonClick();

        // THEN - The controller called the service class and returned a null value
        ((IAccountsService) mocks.verify(serviceMock)).recalculateRating(new List<Account>{ record });
        System.assertEquals(null, result, 'Incorrect returned result');
	}
}