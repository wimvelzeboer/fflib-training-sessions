/**
 * File Name: AccountRatingWebServiceTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@IsTest
private class AccountRatingWebServiceTest
{
	private static final String GET_REQUEST = 'Get';

	@IsTest
	static void testGetRequest()
	{
		// Given - Two hot rated accounts
		Id idA = fflib_IDGenerator.generate(Schema.Account.SObjectType);
		Id idB = fflib_IDGenerator.generate(Schema.Account.SObjectType);

		Set<Id> accountIds = new Set<Id>{ idA, idB };

		List<Account> accountRecords = new List<Account>
		{
				new Account( Id = idA, NumberOfEmployees = 100, Rating = 'Hot'),
				new Account( Id = idB, NumberOfEmployees = 10, Rating = 'Hot')
		};

		// Mock references
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		IAccounts domainMock = (IAccounts) mocks.mock(IAccounts.class);
		IAccountsSelector selectorMock = (IAccountsSelector) mocks.mock(IAccountsSelector.class);
		IAccountsService serviceMock = (IAccountsService) mocks.mock(IAccountsService.class);
		mocks.startStubbing();
		mocks.when(selectorMock.sObjectType()).thenReturn(Schema.Account.SObjectType);
		mocks.when(selectorMock.selectSObjectsById(accountIds)).thenReturn(accountRecords);
		mocks.stopStubbing();
		Application.Service.setMock(IAccountsService.class, serviceMock);
		Application.Selector.setMock(selectorMock);
		Application.Domain.setMock(domainMock);

		// Prepare POST request
		prepareRequest(GET_REQUEST, generateRequestBody(accountIds));

		// WHEN we send a POST request to the webservice with those Account Ids
		System.Test.startTest();
		AccountRatingWebService.ResponseBody responseBody = AccountRatingWebService.doPost();
		System.Test.stopTest();

		// THEN it should return the records and should have invoked the business process for the records
		System.assert(responseBody.Success, 'The request process failed');
		System.assert(responseBody.accountRatings.size() == 2, 'Unexpected size');
		((IAccountsService)	mocks.verify(serviceMock)).recalculateRating((IAccounts) fflib_Match.anyObject());
	}

	@IsTest
	static void testGetRequest_WithImproperData_RequestBodyFailures()
	{
		// Given - Two Ids of different SObjectTypes
		Id idA = fflib_IDGenerator.generate(Schema.Account.SObjectType);
		Id idB = fflib_IDGenerator.generate(Schema.Contact.SObjectType);

		Set<Id> idSet = new Set<Id>{ idA, idB };

		prepareRequest(GET_REQUEST, Blob.valueOf('Make it fail'));

		// WHEN we send a POST request to the webservice with those Account Ids
		System.Test.startTest();
		AccountRatingWebService.ResponseBody responseBody = AccountRatingWebService.doPost();
		System.Test.stopTest();

		// THEN it should return the records and should have invoked the business process for the records
		System.assert(responseBody.Success == false, 'The request process surprisingly succeeded');
		System.assert(
				responseBody.errorResponse.ErrorMessage.contains('Unable to process request body'),
				'The error should include \'Unable to process request body\''
		);
	}

	@IsTest
	static void testGetRequest_WithImproperData_MixedIds()
	{
		// Given - Two Ids of different SObjectTypes
		Id idA = fflib_IDGenerator.generate(Schema.Account.SObjectType);
		Id idB = fflib_IDGenerator.generate(Schema.Contact.SObjectType);

		Set<Id> idSet = new Set<Id>{ idA, idB };

		prepareRequest(GET_REQUEST, generateRequestBody(idSet));

		// WHEN we send a POST request to the webservice with those Account Ids
		System.Test.startTest();
		AccountRatingWebService.ResponseBody responseBody = AccountRatingWebService.doPost();
		System.Test.stopTest();

		// THEN it should return the records and should have invoked the business process for the records
		System.assert(responseBody.Success == false, 'The request process surprisingly succeeded');
		System.assert(
				responseBody.errorResponse.ErrorMessage.contains('Unable to determine SObjectType'),
				'The error should include \'Unable to determine SObjectType\''
		);
	}

	private static void prepareRequest(String requestType, Blob body)
	{
		RestRequest req = new RestRequest();
		RestResponse res = new RestResponse();
		req.requestURI = '/services/apexrest/AccountRating';
		req.httpMethod = requestType;
		req.addHeader('Content-Type', 'application/json');
		req.requestBody = body;
		RestContext.request = req;
		RestContext.response = res;
	}

	private static Blob generateRequestBody(Set<Id> idSet)
	{
		AccountRatingWebService.RequestBody result = new AccountRatingWebService.RequestBody();
		result.AccountIds = idSet;
		return Blob.valueOf(
				JSON.serialize(result)
		);
	}
}