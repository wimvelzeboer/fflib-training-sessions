/**
 * File Name: OpportunitiesServiceImp 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
public with sharing class OpportunitiesServiceImp
		implements OpportunitiesService
{
	public void logLastActivityDateOnParentAccount(Set<Id> opportunityIds)
	{
		logLastActivityDateOnParentAccount(
				(Opportunities) Application.Domain.newInstance(opportunityIds)
		);
	}

	public void logLastActivityDateOnParentAccount(List<Opportunity> opportunityRecords)
	{
		logLastActivityDateOnParentAccount(
				(Opportunities) Application.Domain.newInstance(opportunityRecords)
		);
	}

	public void logLastActivityDateOnParentAccount(Opportunities opportunities) { }
	public void logLastActivityDateOnParentAccount(Opportunities opportunities, Accounts accounts) { }


	public void logLastActivityDateOnParentAccount(
			fflib_ISObjectUnitOfWork unitOfWork,
			Opportunities opportunities,
			Accounts accounts)
	{
		Map<Id, Opportunities> opportunitiesByAccountId = opportunities.getByAccountId();
		Map<Id, Date> lastModifiedDateOpportunityByAccountId =
				getMostRecentLastModifiedDateByAccountId(opportunitiesByAccountId);
		accounts.setLastOpportunityRaisedDate(lastModifiedDateOpportunityByAccountId);
		unitOfWork.registerDirty(accounts);
	}

	private static Map<Id, Date> getMostRecentLastModifiedDateByAccountId(Map<Id, Opportunities> opportunitiesByIds)
	{
		Map<Id, Date> result = new Map<Id, Date>();
		for (Id accountId : opportunitiesByIds.keySet())
		{
			Opportunities opportunities = opportunitiesByIds.get(accountId);
			Datetime dateTime = opportunities.getMostRecentLastModifiedData();
			result.put(accountId, dateTime.date());
		}
		return result;
	}
}