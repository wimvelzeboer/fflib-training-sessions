/**
 * File Name: MyWebService
 * Description:
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@RestResource(urlMapping='/AccountRating')
global with sharing class AccountRatingWebService
{

    /**
	 * Gets the account rating for the given account Id
	 *
	 * @return Instance of ResponseBody containing the Account Ratings grouped by AccountId
	 */
	@HttpGet
	global static ResponseBody doGet()
	{
		try
		{
			RequestBody request = getRequestBody();
			IAccounts accounts = Accounts.newInstance(request.AccountIds);
			return new ResponseBody(accounts);
		}
		catch (Exception e)
		{
            return new ResponseBody(
		            new ErrorResponse(
				            e.getMessage()
		            )
            );
		}
	}

	/**
	 * Posts a request to recalculate the Rating and return the updated values
	 *
	 * @return Instance of ResponseBody containing the updated Account Ratings grouped by AccountId
	 */
	@HttpPost
	global static ResponseBody doPost()
	{
		try
		{
			RequestBody request = getRequestBody();
			IAccounts accounts = Accounts.newInstance(request.AccountIds);
			AccountsService.recalculateRating(accounts);
			return new ResponseBody(accounts);
		}
		catch (Exception e)
		{
			return new ResponseBody(
					new ErrorResponse(
							e.getMessage()
					)
			);
		}
	}

	private static RequestBody getRequestBody()
	{
		try
		{
			RestRequest restRequest = RestContext.request;
			return (RequestBody) JSON.deserialize(restRequest.requestBody.toString(), RequestBody.class);
		}
		catch (Exception e)
		{
			// Maybe add here some extra error logging to capture the stack-trace.
			throw new DeveloperException('Unable to process request body: ' + e.getMessage());
		}
	}

	/**
	 * The
	 */
	public class RequestBody
	{
		public Set<Id> AccountIds { get; set; }
	}

    /**
	 * The response body for the GET request
	 */
	global class ResponseBody
	{
		public Boolean Success { get; set; }
		public List<AccountRating> accountRatings { get; set; }
		public ErrorResponse errorResponse { get; set; }

		public ResponseBody(IAccounts accounts)
		{
			this.Success = true;
			this.accountRatings = new List<AccountRating>();
			for (Account record : accounts.getAccounts())
			{
				this.accountRatings.add(
						new AccountRating(record)
				);
			}
		}

		public ResponseBody(ErrorResponse error)
		{
			this.Success = false;
			this.errorResponse = error;
		}
	}

	private class AccountRating
	{
		public Id AccountId { get; set; }
		public String Rating { get; set; }

		public AccountRating(Account record)
		{
			this.AccountId = record.Id;
			this.Rating = record.Rating;
		}
	}

	public class ErrorResponse
	{
		public String ErrorMessage { get; set; }

        public ErrorResponse(String message)
        {
            this.ErrorMessage = message;
        }
	}

	public class DeveloperException extends Exception {	}

}